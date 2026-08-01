{ config, pkgs, ... }:

{
  # We enable Stylix globally
  stylix.enable = true;

  # But we DISABLE autoEnable so it doesn't hijack your entire system (GTK, KDE, Bat, etc.)
  stylix.autoEnable = false;

  # We only opt-in to WezTerm!
  stylix.targets.wezterm.enable = true;

  # Wallpaper (Stylix needs an image even if we provide a scheme)
  stylix.image = ../../../../Sif.png;

  # Force Gruvbox Light theme
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
  stylix.polarity = "light";
}
