{ config, pkgs, ... }:

{
  imports = [
    ./aliases.nix
  ];

  # Plantilla para paquetes de programas del módulo terminal
  home.packages = with pkgs; [
    # Agrega tus programas de terminal aquí (por ejemplo: git, htop, zsh, etc.)
  ];
}
