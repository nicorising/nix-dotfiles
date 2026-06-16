{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      gruvbox
    ];
  };
}
