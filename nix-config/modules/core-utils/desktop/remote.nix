{ config, pkgs, ... }:

{
  # Herramientas de control y escritorio remoto
  home.packages = with pkgs; [
    weylus
  ];
}
