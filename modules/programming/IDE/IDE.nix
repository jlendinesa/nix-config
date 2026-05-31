{ config, pkgs, ... }:


{
  home.packages = with pkgs; [
    jetbrains.pycharm-oss
    neovim
  ];
}