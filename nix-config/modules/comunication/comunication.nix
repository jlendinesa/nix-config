{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
    zapzap
    brave
    localsend
  ];
}