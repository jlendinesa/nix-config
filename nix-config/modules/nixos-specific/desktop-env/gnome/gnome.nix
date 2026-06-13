{ config, pkgs, ... }:

{
  # --- ESCRITORIO (GNOME) ---
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.desktopManager.gnome.enable = true;

  # --- CONFIGURACIÓN RDP (Remote Desktop) ---
  services.gnome.gnome-remote-desktop.enable = true;
  services.gnome.gnome-keyring.enable = true; # Necesario para guardar credenciales RDP

  # Forzar que el servicio se levante con la sesión gráfica (Solución al estado 'dead')
  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };

  # Apertura de puertos específicos para RDP
  networking.firewall.allowedTCPPorts = [ 3389 ];
  networking.firewall.allowedUDPPorts = [ 3389 ];

  # --- TECLADO Y LOCALIZACIÓN ---
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };
  console.keyMap = "es";

  # --- EXTENSIONES Y PAQUETES ---
  environment.systemPackages = with pkgs; [
    refine
    gnome-extension-manager

    # Extensiones
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.caffeine
    gnomeExtensions.emoji-copy
    gnomeExtensions.just-perfection
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.fuzzy-app-search
    gnomeExtensions.media-controls
    gnomeExtensions.wifi-qrcode
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.user-themes
    gnomeExtensions.workspace-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect

    touchegg
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # --- SERVICIOS ADICIONALES ---
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.touchegg.enable = true;
  services.libinput.enable = true;

  # --- CONFIGURACIÓN DE USUARIO (HOME-MANAGER) ---
  home-manager.users.jose = { pkgs, ... }: {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          clipboard-indicator.extensionUuid
          caffeine.extensionUuid
          emoji-copy.extensionUuid
          just-perfection.extensionUuid
          quick-settings-tweaker.extensionUuid
          fuzzy-app-search.extensionUuid
          media-controls.extensionUuid
          wifi-qrcode.extensionUuid
          bluetooth-battery-meter.extensionUuid
          removable-drive-menu.extensionUuid
          user-themes.extensionUuid
          workspace-indicator.extensionUuid
          x11-gestures.extensionUuid
          dash-to-dock.extensionUuid
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
        ];
      };
    };
  };
}