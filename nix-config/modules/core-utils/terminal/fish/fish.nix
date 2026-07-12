{ config, lib, pkgs, ... }:

{
  imports = [
    ../aliases.nix
  ];

  programs.fish = {
    enable = true;

    # Fish plugins migrated to Nix/Home Manager
    plugins = [
      {
        name = "bobthefish";
        src = pkgs.fishPlugins.bobthefish.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "nvm";
        src = pkgs.fishPlugins.nvm.src;
      }
    ];

    # Custom functions migrated to Nix/Home Manager
    functions = {
      gotowindows = {
        body = ''
          if test -e /dev/sda1
              echo "Disco de Windows detectado. Reiniciando..."
              sudo efibootmgr -n 2001
              sudo reboot
          else
              echo "-------------------------------------------------------"
              echo "ERROR: El disco duro externo de Windows no está conectado."
              echo "-------------------------------------------------------"
          end
        '';
        description = "Reboot directly into Windows if the external drive is connected";
      };

      alert = {
        body = ''
          set icon (test $status -eq 0; and echo terminal; or echo error)
          set message (history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')
          notify-send --urgency=low -i $icon $message
        '';
        description = "Send desktop notification after long-running terminal commands";
      };
    };

    # Interactive shell initialization (migrated from config.fish)
    interactiveShellInit = ''
      # Variables de entorno y PATH
      fish_add_path /home/jose/.spicetify
      fish_add_path /usr/lib/jvm/jdk-21.0.7+6/bin

      set -Ux JAVA_HOME /usr/lib/jvm/jdk-21.0.7+6

      # FNM (Fast Node Manager)
      set FNM_PATH "/home/jose/.local/share/fnm"
      if [ -d "$FNM_PATH" ]
          set PATH "$FNM_PATH" $PATH
          if status --is-interactive
              fnm env --shell fish | source
          end
      end

      # Evitar duplicados en el PATH agregando una vez
      if not contains $HOME/.npm-global/bin $PATH
          set -x PATH $HOME/.npm-global/bin $PATH
      end

      # SpotDL credentials (loaded from local file to avoid exposing secrets on GitHub)
      if test -f ~/.config/fish/secrets.fish
          source ~/.config/fish/secrets.fish
      end

      # opencode
      fish_add_path /home/jose/.opencode/bin
    '';
  };
}

