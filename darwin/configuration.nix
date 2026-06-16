{ ... }:

{
  system = {
    primaryUser = "nrising";
    stateVersion = 6;
  };

  users.users.nrising = {
    name = "nrising";
    home = "/Users/nrising";
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  nix.enable = false;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      InitialKeyRepeat = 12; # ~200ms
      KeyRepeat = 2; # ~30 Hz
      _HIHideMenuBar = true;
    };

    dock.autohide = true;
  };

  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "docker-desktop"
      "nikitabobko/tap/aerospace"
      "postico"
    ];
  };

  programs.zsh.enable = true;
}
