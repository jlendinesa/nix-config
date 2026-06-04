{ config, pkgs, ... }:

{
  # Definimos la configuración de keyd para que Home Manager la genere en ~/.config/keyd/default.conf
  xdg.configFile."keyd/default.conf".text = ''
    [ids]
    *

    [main]
    # Remapear la macro de Copilot a Control Derecho
    leftmeta+leftshift+f23 = rightcontrol
    # Remapear el Intro del teclado numérico al Intro normal
    kpenter = enter
    leftcontrol = leftcontrol
    rightcontrol = rightcontrol

    capslock = layer(letras_rotas)


    [Meta]
    t = C-A-t







    [letras_rotas]
    # g por f y viceversa
    f = g
    g = f

    # h por j y viceversa (por si quieres mantener la simetría)
    j = h
    h = j

    # Nuevas peticiones

    space = leftalt
    down = up

    # Soporte para mayúsculas dentro de la capa
    leftshift+f = G
    leftshift+g = F
  '';
}
