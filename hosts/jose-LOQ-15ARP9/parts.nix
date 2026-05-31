{ config, pkgs, ... }:

{
  imports = [
    ../default.nix
    ../../modules/core-utils/core-utils.nix
    ../../modules/gaming/gaming.nix
    ../../modules/office/office.nix
    ../../modules/programming/programming.nix
  ];

  targets.genericLinux.enable = true;
}
