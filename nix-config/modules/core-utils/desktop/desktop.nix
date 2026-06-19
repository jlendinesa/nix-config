{ config, pkgs, ... }:

{
  imports = [
    ./keyd.nix
  ];

  # Plantilla para paquetes de programas del módulo desktop
  home.packages = with pkgs; [
    # Agrega tus programas de escritorio aquí (por ejemplo: firefox, discord, etc.)
    motrix
  ];
}
