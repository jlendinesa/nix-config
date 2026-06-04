{ config, lib, pkgs, ... }:

let
  # Mapeamos los aliases genéricos de Home Manager al formato de Fish
  aliasLines = lib.mapAttrsToList (name: value: "alias ${name}=\"${value}\"") config.home.shellAliases;
  aliasesContent = lib.concatStringsSep "\n" aliasLines;
in
{
  imports = [
    ../aliases.nix
  ];

  # Generamos el archivo de aliases de fish a partir del home.shellAliases genérico
  xdg.configFile."fish/aliases.fish".text = ''
    # Aliases generados automáticamente desde home.shellAliases
    ${aliasesContent}

    # Notificación tras comandos largos (específico de fish)
    function alert
        set icon (test $status -eq 0; and echo terminal; or echo error)
        set message (history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')
        notify-send --urgency=low -i $icon $message
    end
  '';

  # Hacemos que Home Manager gestione config.fish enlazando el archivo local
  xdg.configFile."fish/config.fish".source = ./config.fish;
}
