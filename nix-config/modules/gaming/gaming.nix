{ config, pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  # Paquetes de programas del módulo gaming
  home.packages = with pkgs; [
    protontricks
  ];
}
