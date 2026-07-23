{ config, pkgs, ... }:

{
  # Plantilla para paquetes de programas del módulo document-editor
  home.packages = with pkgs; [
    libreoffice
    onlyoffice-desktopeditors
    obsidian
  ];
}
