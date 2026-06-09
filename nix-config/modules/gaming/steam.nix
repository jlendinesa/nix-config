{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    steam
  ];

  home.file.".local/share/Steam/compatibilitytools.d/proton-ge-bin".source = pkgs.proton-ge-bin.steamcompattool;
}
