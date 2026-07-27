{ config, pkgs, lib, ... }:

let
  appimageDir = "${config.home.homeDirectory}/.config/home-manager/nix-config/modules/core-utils/appimages";

  # Lista declarativa de AppImages a gestionar y descargar
  appimages = [
    {
      name = "curseforge.appimage";
      url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage";
    }
    {
      name = "nexus_mods_app.appimage";
      url = "https://github.com/Nexus-Mods/NexusMods.App/releases/download/v0.21.1/NexusMods.App.x86_64.AppImage";
    }
  ];

  # Función helper para generar el script de descarga automática
  mkDownloadScript = app: ''
    if [ ! -f "$APPIMAGE_DIR/${app.name}" ]; then
      echo "Downloading ${app.name}..."
      $DRY_RUN_CMD ${pkgs.curl}/bin/curl -L -s "${app.url}" -o "$APPIMAGE_DIR/${app.name}"
      $DRY_RUN_CMD chmod +x "$APPIMAGE_DIR/${app.name}"
    fi
  '';
in
{
  # Paquetes y utilidades para soporte de AppImages
  home.packages = with pkgs; [
    appimage-run
    curl
  ];

  # Descarga automática de AppImages faltantes
  home.activation.downloadAppImages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    APPIMAGE_DIR="${appimageDir}"
    $DRY_RUN_CMD mkdir -p "$APPIMAGE_DIR"
    ${lib.concatMapStringsSep "\n" mkDownloadScript appimages}
  '';

  # Accesos directos (.desktop) declarativos para el menú de aplicaciones
  xdg.desktopEntries = {
    curseforge = {
      name = "CurseForge";
      genericName = "Mod Manager";
      comment = "Mod manager for Minecraft and other games";
      exec = "${appimageDir}/curseforge.appimage --appimage-extract-and-run";
      icon = "${appimageDir}/.icons/curseforge";
      terminal = false;
      categories = [ "Game" ];
    };

    nexus-mods-app = {
      name = "Nexus Mods App";
      genericName = "Mod Manager";
      comment = "Mod manager for games from Nexus Mods";
      exec = "${appimageDir}/nexus_mods_app.appimage --appimage-extract-and-run %u";
      icon = "${appimageDir}/.icons/nexus_mods_app";
      terminal = false;
      categories = [ "Game" ];
      mimeType = [ "x-scheme-handler/nxm" ];
      settings = {
        StartupWMClass = "NexusMods.App";
      };
    };

  };
}


