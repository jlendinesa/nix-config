{ config, pkgs, ... }:

{
  imports = [
    ./steam.nix
  ];

  # Paquetes de programas del módulo gaming
  home.packages = with pkgs; [
    protontricks
    ryubing
    heroic
    lutris
    steam-rom-manager
    retroarch
    cemu
    pcsx2
    shadps4
    sgdboop
    itch
  ];
}
