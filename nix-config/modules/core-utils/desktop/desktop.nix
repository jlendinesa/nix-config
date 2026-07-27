{ config, pkgs, ... }:

{
  imports = [
    ./keyd.nix
    ./remote.nix
  ];

  # Plantilla para paquetes de programas del módulo desktop
  home.packages = with pkgs; [
    # Agrega tus programas de escritorio aquí (por ejemplo: firefox, discord, etc.)
    motrix
    brave
    localsend
    ente-auth
    ryubing
    heroic
    lutris
    steam-rom-manager
    upscayl
    pinta
    fragments
    tailscale
    virtualbox
    retroarch
    megasync
    cemu
    pcsx2
    shadps4
    sgdboop
    docker
    itch
  ];
}
