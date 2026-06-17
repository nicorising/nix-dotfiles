{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    mouse = true;
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      gruvbox
    ];

    extraConfig = ''
      # Pass truecolor through to nixvim so gruvbox renders correctly
      set -ag terminal-overrides ",*:RGB"

      # Let image.nvim's kitty graphics escapes pass through tmux to kitty
      set -gq allow-passthrough on
      set -g visual-activity off
    '';
  };
}
