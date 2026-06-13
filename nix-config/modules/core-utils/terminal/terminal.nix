{ config, pkgs, ... }:

{
  imports = [
    ./fish/fish.nix
    ./wezterm.nix
  ];

  # Plantilla para paquetes de programas del módulo terminal
  home.packages = with pkgs; [
    # Agrega tus programas de terminal aquí (por ejemplo: git, htop, zsh, etc.)
    fish
    tree
    distrobox



    # Terminales
    ghostty
  ];
}
