{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    steam
    proton-ge-bin
  ];

  # Symlink Proton GE into Steam's compatibility tools directory
  home.file.".local/share/Steam/compatibilitytools.d/GE-Proton".source = pkgs.proton-ge-bin.steamcompattool;
}
