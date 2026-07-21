{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/core-utils/core-utils.nix
    ../../modules/core-utils/desktop/spotify.nix
    ../../modules/comunication/cominucation.nix
    ../../modules/gaming/gaming.nix
    ../../modules/office/office.nix
    ../../modules/programming/programming.nix
  ];

  # Modos de los modulos
  #antigravity-non-nixos.mode = "wrapped";
  
  # Activar modulos
  gaming.steam.mode = "wrapped-mesa";

  # Opciones base
  targets.genericLinux.enable = true;
}
