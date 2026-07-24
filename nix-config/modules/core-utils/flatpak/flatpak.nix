{ config, pkgs, lib, ... }:

let
  # Cargar la lista de programas Flatpak desde packages.nix
  flatpakApps = import ./packages.nix;
  flatpakBin = "${pkgs.flatpak}/bin/flatpak";
in
{
  # Asegura que la herramienta flatpak esté presente en el sistema
  home.packages = with pkgs; [
    flatpak
  ];

  # Asegurar que las rutas de las aplicaciones Flatpak se integren con el sistema de escritorio
  xdg.systemDirs.data = [
    "/var/lib/flatpak/exports/share"
    "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
  ];

  # Configuración y descarga automática de repositorios y paquetes Flatpak
  home.activation.setupFlatpaks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    FLATPAK_BIN="${flatpakBin}"
    if [ ! -x "$FLATPAK_BIN" ]; then
      FLATPAK_BIN="$(which flatpak 2>/dev/null || echo "flatpak")"
    fi

    echo "Configurando repositorios y aplicaciones Flatpak..."
    run $FLATPAK_BIN remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    ${lib.concatMapStringsSep "\n" (app: ''
      echo "Instalando/actualizando Flatpak: ${app}..."
      run $FLATPAK_BIN install --user --noninteractive -y flathub ${app} || true
    '') flatpakApps}
  '';
}
