{ config, lib, pkgs, ... }:

{
  imports = [
    ../default.nix
    ../../modules/core-utils/core-utils.nix
    ../../modules/core-utils/desktop/spotify.nix
    ../../modules/gaming/gaming.nix
    ../../modules/office/office.nix
    ../../modules/programming/programming.nix
  ];




  # Modos de los modulos
  #antigravity-non-nixos.mode = "wrapped";
  
  # Activar modulos

  # Opciones base
  targets.genericLinux.enable = true;
}
