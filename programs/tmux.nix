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
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left  'C-h C-Left'
          set -g @vim_navigator_mapping_down  'C-j C-Down'
          set -g @vim_navigator_mapping_up    'C-k C-Up'
          set -g @vim_navigator_mapping_right 'C-l C-Right'
        '';
      }
      resurrect
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];

    extraConfig = ''
      # Pass truecolor and hyperlinks through tmux
      set -as terminal-features ",*:RGB:hyperlinks"

      # Let image.nvim's kitty graphics escapes pass through tmux to kitty
      set -gq allow-passthrough on
      set -g visual-activity off

      # Forward terminal focus events to running programs
      set -g focus-events on

      # Better pane splitting
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Resize panes with prefix + arrows
      bind -r Left  resize-pane -L 5
      bind -r Down  resize-pane -D 5
      bind -r Up    resize-pane -U 5
      bind -r Right resize-pane -R 5

      # Specific applications to resurrect
      set -g @resurrect-processes '"~btop" "~claude" "~nvim->nvim ."'
    '';
  };
}
