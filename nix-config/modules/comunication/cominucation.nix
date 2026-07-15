{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    zapzap
  ];
}