{ config, pkgs, ... }:

{
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
        color_scheme = "Catppuccin Mocha", -- You can change this to any built-in theme
        enable_wayland = false, -- Zorin is X11 by default

        -- Transparency
        window_background_opacity = 0.95,
        text_background_opacity = 1.0,

        -- Window size and spacing
        initial_cols = 121,
        initial_rows = 33,
        line_height = 1.0, -- set to 1.0 for better vertical spacing (0.8 is tight)
      }
    '';
  };

  # Configurar Wezterm como el terminal predeterminado (usado por xdg-terminal-exec)
  xdg.configFile."xdg-terminals.list".text = ''
    org.wezfurlong.wezterm.desktop
  '';
  xdg.configFile."zorin-xdg-terminals.list".text = ''
    org.wezfurlong.wezterm.desktop
  '';
  xdg.configFile."GNOME-xdg-terminals.list".text = ''
    org.wezfurlong.wezterm.desktop
  '';
}
