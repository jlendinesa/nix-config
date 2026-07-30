{ config, pkgs, ... }:

{
  # Herramientas de control, escritorio remoto y redes
  home.packages = with pkgs; [
    weylus
    tailscale
    trayscale
  ];

  services.trayscale.enable = true;
}

