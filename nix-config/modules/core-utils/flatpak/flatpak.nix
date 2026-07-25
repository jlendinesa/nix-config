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

  # Integración de rutas XDG para accesos directos
  xdg.systemDirs.data = [
    "/var/lib/flatpak/exports/share"
    "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
  ];

  # Servicio systemd de usuario para garantizar la ejecución del portal D-Bus de Flatpak
  systemd.user.services.flatpak-portal = {
    Unit = {
      Description = "Servicio Portal D-Bus de Flatpak";
    };
    Service = {
      ExecStart = "${pkgs.flatpak}/libexec/flatpak-portal --replace";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Configuración, descarga de Flatpaks y vinculación directa de lanzadores e iconos
  home.activation.setupFlatpaks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "=========================================================="
    echo " [Flatpak] Iniciando configuración de entorno Flatpak"
    echo "=========================================================="

    FLATPAK_BIN="${flatpakBin}"
    if [ ! -x "$FLATPAK_BIN" ]; then
      FLATPAK_BIN="$(which flatpak 2>/dev/null || echo "flatpak")"
    fi

    echo " [Flatpak] Usando binario: $FLATPAK_BIN"
    echo " [Flatpak] Asegurando repositorio Flathub para el usuario..."
    run $FLATPAK_BIN remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    ${lib.concatMapStringsSep "\n" (app: ''
      echo " [Flatpak] Procesando aplicación: ${app}..."
      run $FLATPAK_BIN install --user --noninteractive -y flathub ${app} || true
    '') flatpakApps}

    echo " [Flatpak] Sincronizando accesos directos, servicios e iconos..."
    $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.local/share/applications"
    $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.local/share/icons/hicolor"
    $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/.local/share/dbus-1/services"

    # Enlazar servicios D-Bus para integración con portales
    if [ -d "${pkgs.flatpak}/share/dbus-1/services" ]; then
      echo "  -> Sincronizando servicios D-Bus del sistema..."
      $DRY_RUN_CMD cp -fL "${pkgs.flatpak}/share/dbus-1/services/"*.service "${config.home.homeDirectory}/.local/share/dbus-1/services/" 2>/dev/null || true
    fi

    # Copiar lanzadores (.desktop) y deshabilitar DBusActivatable para evitar fallos de activacion D-Bus en KDE Plasma / GNOME
    if [ -d "${config.home.homeDirectory}/.local/share/flatpak/exports/share/applications" ]; then
      echo "  -> Sincronizando lanzadores .desktop y configurando modo directo de ejecución..."
      $DRY_RUN_CMD cp -fL "${config.home.homeDirectory}/.local/share/flatpak/exports/share/applications/"*.desktop "${config.home.homeDirectory}/.local/share/applications/" 2>/dev/null || true
      $DRY_RUN_CMD sed -i 's/DBusActivatable=true/DBusActivatable=false/g' "${config.home.homeDirectory}/.local/share/applications/"*.desktop 2>/dev/null || true
    fi

    # Enlazar árbol de iconos a ~/.local/share/icons/hicolor
    if [ -d "${config.home.homeDirectory}/.local/share/flatpak/exports/share/icons/hicolor" ]; then
      echo "  -> Sincronizando estructura de iconos hicolor..."
      $DRY_RUN_CMD cp -rsf "${config.home.homeDirectory}/.local/share/flatpak/exports/share/icons/hicolor/"* "${config.home.homeDirectory}/.local/share/icons/hicolor/" 2>/dev/null || true
    fi

    # Actualizar la caché de iconos si el comando está disponible
    if command -v gtk-update-icon-cache >/dev/null 2>&1; then
      echo "  -> Actualizando la caché de iconos del sistema (gtk-update-icon-cache)..."
      $DRY_RUN_CMD gtk-update-icon-cache -f -t "${config.home.homeDirectory}/.local/share/icons/hicolor" 2>/dev/null || true
    fi

    echo "=========================================================="
    echo " [Flatpak] Configuración de Flatpak completada con éxito"
    echo "=========================================================="
  '';
}
