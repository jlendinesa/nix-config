{ config, pkgs, lib, ... }:

let
  colors = import ./colors.nix;
  theme = colors.gruvbox-light;
in
{
  # Generate the Brave theme manifest
  home.file.".config/brave-gruvbox-light/manifest.json".text = builtins.toJSON {
    manifest_version = 3;
    version = "1.5";
    name = "Brave Gruvbox Precision";
    theme = {
      colors = {
        frame = theme.rgb.frame;
        toolbar = theme.rgb.toolbar;
        tab_text = theme.rgb.tab_text;
        tab_background_text = theme.rgb.tab_background_text;
        bookmark_text = theme.rgb.bookmark_text;
        ntp_background = theme.rgb.ntp_background;
        ntp_text = theme.rgb.ntp_text;
      };
    };
  };

  # Generate KDE Plasma color scheme
  home.file.".local/share/color-schemes/GruvboxLight.colors".text = ''
    [ColorEffects:Disabled]
    Color=56,56,56
    ColorAmount=0
    ColorEffect=0
    ContrastAmount=0.65
    ContrastEffect=1
    IntensityAmount=0.1
    IntensityEffect=2

    [ColorEffects:Inactive]
    ChangeSelectionColor=true
    Color=112,111,110
    ColorAmount=0.025
    ColorEffect=2
    ContrastAmount=0.1
    ContrastEffect=2
    Enable=false
    IntensityAmount=0
    IntensityEffect=0

    [Colors:Button]
    BackgroundAlternate=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    BackgroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    DecorationFocus=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    DecorationHover=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundActive=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundInactive=${builtins.concatStringsSep "," (map toString theme.rgb.fg_dim)}
    ForegroundLink=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundNegative=${builtins.concatStringsSep "," (map toString theme.rgb.red)}
    ForegroundNeutral=${builtins.concatStringsSep "," (map toString theme.rgb.orange)}
    ForegroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.fg)}
    ForegroundPositive=${builtins.concatStringsSep "," (map toString theme.rgb.green)}
    ForegroundVisited=${builtins.concatStringsSep "," (map toString theme.rgb.purple)}

    [Colors:Selection]
    BackgroundAlternate=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    BackgroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    DecorationFocus=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    DecorationHover=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundActive=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    ForegroundInactive=${builtins.concatStringsSep "," (map toString theme.rgb.fg_dim)}
    ForegroundLink=${builtins.concatStringsSep "," (map toString theme.rgb.yellow)}
    ForegroundNegative=${builtins.concatStringsSep "," (map toString theme.rgb.red)}
    ForegroundNeutral=${builtins.concatStringsSep "," (map toString theme.rgb.orange)}
    ForegroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    ForegroundPositive=${builtins.concatStringsSep "," (map toString theme.rgb.green)}
    ForegroundVisited=${builtins.concatStringsSep "," (map toString theme.rgb.purple)}

    [Colors:Tooltip]
    BackgroundAlternate=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    BackgroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    DecorationFocus=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    DecorationHover=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundActive=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundInactive=${builtins.concatStringsSep "," (map toString theme.rgb.fg_dim)}
    ForegroundLink=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundNegative=${builtins.concatStringsSep "," (map toString theme.rgb.red)}
    ForegroundNeutral=${builtins.concatStringsSep "," (map toString theme.rgb.orange)}
    ForegroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.fg)}
    ForegroundPositive=${builtins.concatStringsSep "," (map toString theme.rgb.green)}
    ForegroundVisited=${builtins.concatStringsSep "," (map toString theme.rgb.purple)}

    [Colors:View]
    BackgroundAlternate=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    BackgroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    DecorationFocus=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    DecorationHover=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundActive=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundInactive=${builtins.concatStringsSep "," (map toString theme.rgb.fg_dim)}
    ForegroundLink=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundNegative=${builtins.concatStringsSep "," (map toString theme.rgb.red)}
    ForegroundNeutral=${builtins.concatStringsSep "," (map toString theme.rgb.orange)}
    ForegroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.fg)}
    ForegroundPositive=${builtins.concatStringsSep "," (map toString theme.rgb.green)}
    ForegroundVisited=${builtins.concatStringsSep "," (map toString theme.rgb.purple)}

    [Colors:Window]
    BackgroundAlternate=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    BackgroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    DecorationFocus=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    DecorationHover=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundActive=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundInactive=${builtins.concatStringsSep "," (map toString theme.rgb.fg_dim)}
    ForegroundLink=${builtins.concatStringsSep "," (map toString theme.rgb.blue)}
    ForegroundNegative=${builtins.concatStringsSep "," (map toString theme.rgb.red)}
    ForegroundNeutral=${builtins.concatStringsSep "," (map toString theme.rgb.orange)}
    ForegroundNormal=${builtins.concatStringsSep "," (map toString theme.rgb.fg)}
    ForegroundPositive=${builtins.concatStringsSep "," (map toString theme.rgb.green)}
    ForegroundVisited=${builtins.concatStringsSep "," (map toString theme.rgb.purple)}

    [General]
    ColorScheme=GruvboxLight
    Name=Gruvbox Light
    shadeSortColumn=true

    [KDE]
    contrast=4

    [WM]
    activeBackground=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    activeBlend=${builtins.concatStringsSep "," (map toString theme.rgb.bg_dim)}
    activeForeground=${builtins.concatStringsSep "," (map toString theme.rgb.fg)}
    inactiveBackground=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    inactiveBlend=${builtins.concatStringsSep "," (map toString theme.rgb.bg)}
    inactiveForeground=${builtins.concatStringsSep "," (map toString theme.rgb.fg_dim)}
  '';
}
