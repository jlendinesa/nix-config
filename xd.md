Neovim (io.neovim.nvim)

Flatseal (com.github.tchx84.Flatseal) - Esencial para gestionar permisos.

Warehouse (io.github.flattool.Warehouse)


Cisco Packet Tracer (packettracer) - Vital para tus repasos y exámenes de redes
ADB & Fastboot (adb, fastboot) - Para tus dispositivos móviles.
CurseForge (curseforge) - Para gestionar tus modpacks de Minecraft.
Autofirma (autofirma) 
Google Chrome (google-chrome-stable)

  


  
  
  
  
  
  
  

Herramientas de Desarrollo (Mejor en nix-shell / direnv)

En NixOS, es recomendable no instalar estos paquetes a nivel de sistema, sino llamarlos declarativamente por proyecto cuando programes:

Java: openjdk-8-jdk, openjdk-17-jdk, openjdk-21-jdk, maven.
C/C++: gcc, g++, cmake, make, ninja-build.
Python/Ruby/Perl: Tenías instalados cientos de módulos (ej. python3-pip, ruby-rubygems). En Nix, los gestionarás con python3Packages o archivos flake.nix por repositorio.

  
  
  

Network/Monitoring Tools: nmap (si lo usas, aunque vi tcpdump), wireshark (no listado pero recomendado), inxi, lsof, jq, bat, fzf, stacer.

Gaming y Emulación

Moonlight (com.moonlight_stream.Moonlight)
itch (io.itch.itch)
GameMode (gamemode) - Optimización de rendimiento.
MangoHud (mangohud) - Para monitorizar los FPS y las temperaturas.
