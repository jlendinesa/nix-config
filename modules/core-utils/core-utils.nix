{ config, pkgs, ... }:

{
  imports = [
    ./desktop/desktop.nix
    ./terminal/terminal.nix
  ];

  # Plantilla para paquetes de programas del módulo core-utils
  home.packages = with pkgs; [
    # Agrega tus programas generales de core-utils aquí
  ];
}
