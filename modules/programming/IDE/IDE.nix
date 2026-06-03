{ config, pkgs, ... }:


{
  imports = [
    ./antigravity.nix
  ];

  home.packages = with pkgs; [
    jetbrains.pycharm-oss
    neovim
  ];
}
