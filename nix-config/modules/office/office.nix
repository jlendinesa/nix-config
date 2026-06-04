{ config, pkgs, ... }:

{
  imports = [
    ./Image/Image.nix
    ./document-editor/document-editor.nix
  ];

  # Plantilla para paquetes de programas del módulo office
  home.packages = with pkgs; [
    # Agrega tus programas generales de office aquí (por ejemplo: thunderbird, etc.)
  ];
}
