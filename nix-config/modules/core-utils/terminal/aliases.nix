{ config, pkgs, ... }:

{
  xdg.configFile."fish/aliases.fish".text = ''
    # Aliases personalizados
    alias ff="fastfetch"

    # Aliases de ls
    alias ls="ls --color=auto"
    alias ll="ls -alF"
    alias la="ls -A"
    alias l="ls -CF"

    # Aliases de grep
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"

    # Alias de bat
    alias bat="batcat"

    # Alias de home-manager switch con flake
    alias hms="home-manager switch --flake ~/.config/home-manager"

    # Notificación tras comandos largos
    function alert
        set icon (test $status -eq 0; and echo terminal; or echo error)
        set message (history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')
        notify-send --urgency=low -i $icon $message
    end
  '';
}
