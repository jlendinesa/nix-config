{ config, lib, pkgs, ... }:

{
  imports = [
    ../aliases.nix
  ];

  programs.fish = {
    enable = true;

    # Fish plugins super completos integrados en Nix/Home Manager
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
        name = "nvm";
        src = pkgs.fishPlugins.nvm.src;
      }
      {
        # Notificaciones de escritorio cuando terminan comandos largos
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        # Cierre automático de comillas y paréntesis tipo IDE
        name = "autopair";
        src = pkgs.fishPlugins.autopair-fish.src;
      }
      {
        # Expansión rápida de rutas ("..." -> "../../", etc.)
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        # Páginas de ayuda "man" en colores
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        # Interfaz interactiva para Git con fzf (glog, gdf, ga, gcb)
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        # Limpieza de historial: evita guardar comandos con errores tipográficos o fallidos
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        # Recordatorio inteligente cuando escribes un comando largo teniendo un alias definido
        name = "fish-you-should-use";
        src = pkgs.fishPlugins.fish-you-should-use.src;
      }
      {
        # Añade sudo rápidamente al comando actual con un atajo (Esc dos veces)
        name = "plugin-sudope";
        src = pkgs.fishPlugins.plugin-sudope.src;
      }
      {
        # Coloreado genérico mejorado para la salida de terminal
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        # Autocompletado flotante interactivo e inteligente con fzf
        name = "fifc";
        src = pkgs.fishPlugins.fifc.src;
      }
      {
        # Salto rápido a cualquier directorio padre ("bd <nombre>")
        name = "fish-bd";
        src = pkgs.fishPlugins.fish-bd.src;
      }
      {
        # Muestra la duración de ejecución de comandos en formato humano (ej. 2m 15s)
        name = "humantime-fish";
        src = pkgs.fishPlugins.humantime-fish.src;
      }
      {
        # Abreviaturas automáticas para comandos Git
        name = "git-abbr";
        src = pkgs.fishPlugins.git-abbr.src;
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
      # Desactivar el saludo por defecto de Fish
      set -g fish_greeting ""

      # Variables de entorno y PATH portables para cualquier sistema
      if test -d $HOME/.spicetify
          fish_add_path $HOME/.spicetify
      end

      if test -d /usr/lib/jvm/jdk-21.0.7+6/bin
          fish_add_path /usr/lib/jvm/jdk-21.0.7+6/bin
          set -Ux JAVA_HOME /usr/lib/jvm/jdk-21.0.7+6
      end

      # FNM (Fast Node Manager)
      set FNM_PATH "$HOME/.local/share/fnm"
      if test -d "$FNM_PATH"
          set PATH "$FNM_PATH" $PATH
          if status --is-interactive
              fnm env --shell fish | source
          end
      end

      # Evitar duplicados en el PATH agregando una vez
      if test -d $HOME/.npm-global/bin
          if not contains $HOME/.npm-global/bin $PATH
              set -x PATH $HOME/.npm-global/bin $PATH
          end
      end

      # SpotDL credentials (loaded from local file to avoid exposing secrets on GitHub)
      if test -f ~/.config/fish/secrets.fish
          source ~/.config/fish/secrets.fish
      end

      # opencode
      if test -d $HOME/.opencode/bin
          fish_add_path $HOME/.opencode/bin
      end
    '';
  };

  # Integraciones modernas de terminal en formato Home Manager
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
}

