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
      vim-tmux-navigator
      resurrect
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];

    extraConfig = ''
      # Pass truecolor through tmux
      set -as terminal-features ",*:RGB"

      # Let image.nvim's kitty graphics escapes pass through tmux to kitty
      set -gq allow-passthrough on
      set -g visual-activity off

      # Forward terminal focus events to running programs (e.g., so they can repaint)
      set -g focus-events on

      # Better pane splitting
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Specific applications to resurrect
      set -g @resurrect-processes '"~btop" "~claude" "~nvim->nvim ."'
    '';
  };
}
