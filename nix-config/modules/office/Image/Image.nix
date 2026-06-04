{ config, pkgs, ... }:

{
  # Plantilla para paquetes de programas del módulo Image
  home.packages = with pkgs; [
    (pkgs.runCommand "krita-wrapped" {
      nativeBuildInputs = [ makeWrapper ];
    } ''
      mkdir -p $out/bin
      mkdir -p $out/share/applications
      
      # Envolvemos el binario
      makeWrapper ${pkgs.krita}/bin/krita $out/bin/krita \
        --set QT_XCB_GL_INTEGRATION none
        
      # Copiamos el acceso directo del menú y el icono
      cp -r ${pkgs.krita}/share/icons $out/share/
      cp ${pkgs.krita}/share/applications/org.kde.krita.desktop $out/share/applications/
      
      # Ajustamos el acceso directo para que use nuestro binario envuelto
      substituteInPlace $out/share/applications/org.kde.krita.desktop \
        --replace "Exec=krita" "Exec=$out/bin/krita"
    '')
  ];
}
