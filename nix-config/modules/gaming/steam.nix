{ config, pkgs, lib, inputs, ... }:

let
  cfg = config.gaming.steam;

  # Wrap Steam and Steam-run using nixGL for hardware-accelerated rendering on non-NixOS
  steam-wrapped = pkgs.symlinkJoin {
    name = "steam-wrapped";
    paths = [ pkgs.steam ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/steam \
        --set __NV_PRIME_RENDER_OFFLOAD 1 \
        --set __GLX_VENDOR_LIBRARY_NAME nvidia \
        --set __VK_LAYER_NV_optimus NVIDIA_only \
        --run "exec ${pkgs.nixgl.nixVulkanNvidia}/bin/${pkgs.nixgl.nixVulkanNvidia.name} ${pkgs.steam}/bin/steam \"\$@\""
    '';
  };

  steam-run-wrapped = pkgs.symlinkJoin {
    name = "steam-run-wrapped";
    paths = [ pkgs.steam-run ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/steam-run \
        --set __NV_PRIME_RENDER_OFFLOAD 1 \
        --set __GLX_VENDOR_LIBRARY_NAME nvidia \
        --set __VK_LAYER_NV_optimus NVIDIA_only \
        --run "exec ${pkgs.nixgl.nixVulkanNvidia}/bin/${pkgs.nixgl.nixVulkanNvidia.name} ${pkgs.steam-run}/bin/steam-run \"\$@\""
    '';
  };
in
{
  options = {
    gaming.steam.mode = lib.mkOption {
      type = lib.types.enum [ "wrapped" "native" "disabled" ];
      default = "disabled";
      description = ''
        Modo de instalación para Steam:
          - "wrapped": Versión envuelta con nixGL para aceleración por hardware híbrida NVIDIA en entornos non-NixOS.
          - "native": Instalación normal directa de Steam (ideal para NixOS o cuando no se requiera nixGL).
          - "disabled": No instalar Steam.
      '';
    };
  };

  config = lib.mkMerge [
    # Caso 'wrapped' (nixGL)
    (lib.mkIf (cfg.mode == "wrapped") {
      nixpkgs.overlays = [
        (final: prev: {
          # Intercept nvidia_x11 override to strip the 'kernel' argument which was removed in recent nixpkgs
          linuxPackages = prev.linuxPackages // {
            nvidia_x11 = let
              intercept = drv: drv // {
                override = args: intercept (drv.override (builtins.removeAttrs args [ "kernel" ]));
                overrideAttrs = f: intercept (drv.overrideAttrs f);
              };
            in (intercept prev.linuxPackages.nvidia_x11).overrideAttrs (oldAttrs: {
              postInstall = (if oldAttrs.postInstall or null != null then oldAttrs.postInstall else "") + ''
                # Create symlinks with the specific filenames expected by nixGL
                mkdir -p $out/share/vulkan/icd.d
                ln -sf nvidia_icd.json $out/share/vulkan/icd.d/nvidia_icd.x86_64.json
                if [ -n "''${lib32:-}" ]; then
                  mkdir -p $lib32/share/vulkan/icd.d
                  ln -sf nvidia_icd.json $lib32/share/vulkan/icd.d/nvidia_icd.i686.json
                fi
              '';
            });
          };

          nixgl = import inputs.nixgl {
            pkgs = final;
            enable32bits = final.system == "x86_64-linux";
            nvidiaVersion = "595.71.05";
            nvidiaHash = "sha256-NiA7iWC35JyKQva6H1hjzeNKBek9KyS3mK8G3YRva4I=";
          };
        })
      ];

      home.packages = [
        steam-wrapped
        steam-run-wrapped
      ];
      home.file.".local/share/Steam/compatibilitytools.d/proton-ge-bin".source = pkgs.proton-ge-bin.steamcompattool;
    })

    # Caso 'native' (Instalación limpia de Steam)
    (lib.mkIf (cfg.mode == "native") {
      home.packages = [
        pkgs.steam
        pkgs.steam-run
      ];
      home.file.".local/share/Steam/compatibilitytools.d/proton-ge-bin".source = pkgs.proton-ge-bin.steamcompattool;
    })
  ];
}
