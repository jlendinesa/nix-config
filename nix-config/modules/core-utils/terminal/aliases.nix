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
    cls = "clear";

    # Aliases de grep
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";

    # Alias de bat
    bat = "batcat";
    hmsupdate = "hmsu";
  };

  # Scripts para comandos más complejos que fallan como aliases en algunas shells (ej. fish)
  home.packages = [
    (pkgs.writeShellScriptBin "hms" ''
      home-manager switch -b backup --flake ~/.config/home-manager "$@" && {
        kbuildsycoca6 2>/dev/null || update-desktop-database ~/.nix-profile/share/applications 2>/dev/null || true
      }
    '')
    (pkgs.writeShellScriptBin "hmsupdate" ''
      nix flake update --flake ~/.config/home-manager "$@" &&
      home-manager switch -b backup --flake ~/.config/home-manager "$@" && {
        kbuildsycoca6 2>/dev/null || update-desktop-database ~/.nix-profile/share/applications 2>/dev/null || true
      }
    '')
  ];
}
