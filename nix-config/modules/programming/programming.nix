{ config, pkgs, ... }:

{
  imports = [
    ./IDE/IDE.nix
    ./languages/languages.nix
  ];

  # Plantilla para paquetes de programas del módulo programming
  home.packages = with pkgs; [
    # Agrega tus programas generales de programming aquí (por ejemplo: python3, gcc, etc.)
    docker
    opencode
  ];
}
