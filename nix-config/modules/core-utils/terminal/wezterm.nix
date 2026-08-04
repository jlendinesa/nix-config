{ config, pkgs, ... }:

let
  colors = import ../theming/colors.nix;
  theme = colors.gruvbox-light.hex;
in
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig.enable = true;

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      return {
        -- Clean, native window bar
        use_fancy_tab_bar = false,
        hide_tab_bar_if_only_one_tab = false,
        enable_tab_bar = true,
        window_decorations = "TITLE|RESIZE",

        -- Font (important for LazyVim icons!)
        font = wezterm.font_with_fallback({
          "JetBrainsMono Nerd Font",
          "Symbols Nerd Font Mono",
        }),
        font_size = 11.5,

        -- Colors and appearance
        colors = {
          foreground = "${theme.fg}",
          background = "${theme.bg}",
          cursor_bg = "${theme.cursor}",
          cursor_fg = "${theme.cursor_text}",
          cursor_border = "${theme.cursor}",
          selection_fg = "${theme.bg}",
          selection_bg = "${theme.blue}",
          scrollbar_thumb = "${theme.fg_dim}",
          split = "${theme.bg_dim}",
          ansi = {
            "${theme.bg}",
            "${theme.red}",
            "${theme.green}",
            "${theme.yellow}",
            "${theme.blue}",
            "${theme.purple}",
            "${theme.aqua}",
            "${theme.fg_dim}"
          },
          brights = {
            "${theme.fg_dim}",
            "${theme.red}",
            "${theme.green}",
            "${theme.yellow}",
            "${theme.blue}",
            "${theme.purple}",
            "${theme.aqua}",
            "${theme.fg}"
          },
        },
        enable_wayland = false, -- Zorin is X11 by default

        -- Transparency
        window_background_opacity = 0.95,
        text_background_opacity = 1.0,

        -- Window size and spacing
        initial_cols = 150,
        initial_rows = 33,
        line_height = 1.0, -- set to 1.0 for better vertical spacing (0.8 is tight)
        enable_scroll_bar = true,
      }
    '';
  };

  # Configurar Wezterm como el terminal predeterminado (usado por xdg-terminal-exec)
  xdg.configFile."xdg-terminals.list" = {
    text = ''
      org.wezfurlong.wezterm.desktop
    '';
    force = true;
  };
  xdg.configFile."zorin-xdg-terminals.list" = {
    text = ''
      org.wezfurlong.wezterm.desktop
    '';
    force = true;
  };
  xdg.configFile."GNOME-xdg-terminals.list" = {
    text = ''
      org.wezfurlong.wezterm.desktop
    '';
    force = true;
  };

  # Atajo de teclado para KDE Plasma (Ctrl+Alt+T abre WezTerm)
  xdg.desktopEntries."org.wezfurlong.wezterm" = {
    name = "WezTerm";
    comment = "Wez's Terminal Emulator";
    icon = "org.wezfurlong.wezterm";
    exec = "wezterm start --cwd .";
    categories = [ "System" "TerminalEmulator" "Utility" ];
    terminal = false;
    settings = {
      "X-KDE-Shortcuts" = "Ctrl+Alt+T";
    };
  };
}
