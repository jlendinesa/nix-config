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

    # Alias de home-manager switch con flake
    hms = "home-manager switch --flake ~/.config/home-manager";
  };
}
