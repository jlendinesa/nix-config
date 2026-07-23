# ~/.config/fish/config.fish

# Cargar aliases externos si existen
if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
end

# Variables de entorno y PATH portables
if test -d $HOME/.spicetify
    fish_add_path $HOME/.spicetify
end

if test -d /usr/lib/jvm/jdk-21.0.7+6/bin
    fish_add_path /usr/lib/jvm/jdk-21.0.7+6/bin
    set -Ux JAVA_HOME /usr/lib/jvm/jdk-21.0.7+6
end

if test -d $HOME/.npm-global/bin
    if not contains $HOME/.npm-global/bin $PATH
        set -x PATH $HOME/.npm-global/bin $PATH
    end
end

# SpotDL credentials (loaded from local file to avoid exposing secrets on GitHub)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

set -gx XDG_DATA_DIRS "$HOME/.nix-profile/share" $XDG_DATA_DIRS

# opencode
if test -d $HOME/.opencode/bin
    fish_add_path $HOME/.opencode/bin
end
