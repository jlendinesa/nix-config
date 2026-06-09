{ config, pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  # Plantilla para paquetes de programas del módulo gaming
  home.packages = with pkgs; [
    # Agrega tus programas de videojuegos aquí (por ejemplo: steam, lutris, etc.)
  ];
}
