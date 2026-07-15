# ~/.config/fish/config.fish

# Cargar aliases externos
source ~/.config/fish/aliases.fish

# Variables de entorno y PATH
fish_add_path /home/jose/.spicetify
fish_add_path /usr/lib/jvm/jdk-21.0.7+6/bin

# fnm (Fast Node Manager) - handled by conf.d/fnm.fish

set -Ux JAVA_HOME /usr/lib/jvm/jdk-21.0.7+6

set -x PATH $HOME/.npm-global/bin $PATH
set -x PATH $HOME/.npm-global/bin $PATH

# SpotDL credentials (loaded from local file to avoid exposing secrets on GitHub)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end
set -gx XDG_DATA_DIRS "$HOME/.nix-profile/share" $XDG_DATA_DIRS
# opencode
fish_add_path /home/jose/.opencode/bin
