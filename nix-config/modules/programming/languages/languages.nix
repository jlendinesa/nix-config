{ config, pkgs, ... }:

{
  # Plantilla para paquetes de programas del módulo languages
  home.packages = with pkgs; [
    php
  ];
}
