{ lib, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "NotoSansM NFM";
      size = lib.mkDefault 10;
    };

    settings = {
      background_opacity = 0.95;
      confirm_os_window_close = 0;
      macos_quit_when_last_window_closed = "yes";
    };

    themeFile = "gruvbox-dark-hard";
  };
}
