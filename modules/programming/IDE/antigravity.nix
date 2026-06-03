{ config, lib, pkgs, ... }:

let
  cfg = config.antigravity-non-nixos;
in
{
  ## 1. Definición de la opción tipo Enum
  options = {
    antigravity-non-nixos.mode = lib.mkOption {
      type = lib.types.enum [ "wrapped" "fhs" "disabled" ];
      default = "disabled";
      description = ''
        Modo de instalación para Antigravity:
          - "wrapped": Versión con wrapper y rutas absolutas (ideal para entornos non-NixOS).
          - "fhs": Versión nativa directa para entornos NixOS (antigravity-fhs).
          - "disabled": No instalar el paquete.
      '';
    };
  };

  ## 2. Configuración condicional según el modo seleccionado
  config = lib.mkMerge [
    # Caso 'wrapped' (Tu script para non-NixOS)
    (lib.mkIf (cfg.mode == "wrapped") {
      home.packages = with pkgs; [
        (pkgs.runCommand "antigravity-wrapped" {
          nativeBuildInputs = [ makeWrapper ];
        } ''
          mkdir -p $out/bin
          
          # Envolvemos el binario
          makeWrapper ${pkgs.antigravity}/bin/antigravity $out/bin/antigravity
             
          # Copiamos todo el contenido de share del paquete original
          if [ -d ${pkgs.antigravity}/share ]; then
            cp -r ${pkgs.antigravity}/share $out/
            chmod -R +w $out/share
          fi
          
          # Ajustamos el acceso directo para que use nuestro binario envuelto e iconos con ruta absoluta
          for f in $out/share/applications/*.desktop; do
            substituteInPlace "$f" \
              --replace "${pkgs.antigravity}/bin/antigravity" "$out/bin/antigravity" \
              --replace "Exec=antigravity" "Exec=$out/bin/antigravity"
            
            icon_name=$(grep -E "^Icon=" "$f" | cut -d= -f2)
            if [ -n "$icon_name" ]; then
              icon_file=$(find $out/share/ Glastonbury -name "$icon_name.*" | head -n 1)
              if [ -n "$icon_file" ]; then
                substituteInPlace "$f" --replace "Icon=$icon_name" "Icon=$icon_file"
              fi
            fi
          done
        '')
      ];
    })

    # Caso 'fhs' (Versión directa para NixOS)
    (lib.mkIf (cfg.mode == "fhs") {
      home.packages = [
        pkgs.antigravity-fhs
      ];
    })
  ];
}