{ config, pkgs, ... }:

{
  # Definición genérica de aliases válidos para cualquier shell (bash, zsh, fish)
  home.shellAliases = {
    ff = "fastfetch";

    # Aliases de ls
    ls = "ls --color=auto";
    ll = "ls -alF";
    la = "ls -A";
    l = "ls -CF";

    # Aliases de grep
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";

    # Alias de bat
    bat = "batcat";

    # Alias de home-manager switch con flake (con backup automático de archivos conflictivos)
    hms = "home-manager switch -b backup --flake ~/.config/home-manager";

    # Alias para actualizar el flake.lock y aplicar los cambios
    hmsupdate = "nix flake update --flake ~/.config/home-manager && home-manager switch -b backup --flake ~/.config/home-manager";
  };
}
