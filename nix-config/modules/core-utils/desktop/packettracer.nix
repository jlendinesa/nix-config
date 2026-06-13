{ config, pkgs, ... }:

{
  home.packages = [
    # Lanzador para Packet Tracer exportado de Distrobox
    (pkgs.makeDesktopItem {
      name = "packettracer";
      desktopName = "Cisco Packet Tracer";
      genericName = "Network Simulator";
      exec = "/home/jose/.local/bin/packettracer";
      terminal = false;
      categories = [ "Network" "Education" ];
      icon = "network-wired";
    })
  ];
}