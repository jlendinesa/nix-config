{ config, pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  # Plantilla para paquetes de programas del módulo gaming
  home.packages = with pkgs; [
  ];
}
