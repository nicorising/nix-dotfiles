{ ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 10;
    terminal = "tmux-256color";
  };
}
