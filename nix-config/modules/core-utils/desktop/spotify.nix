{ config, pkgs, inputs, ... }:

let
  # Retrieve themes and extensions directly from the flake inputs
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    # Import the Home Manager module from the flake input
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    
    # Custom apps to enable (Marketplace)
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];

    # Extensions to enable
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];

    # Sleek Catppuccin Mocha theme
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
