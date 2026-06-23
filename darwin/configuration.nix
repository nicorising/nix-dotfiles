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

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.enable = false;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      InitialKeyRepeat = 12; # ~200ms
      KeyRepeat = 2; # ~30 Hz
    };

    dock.autohide = true;
  };

  power.sleep = {
    display = 10;
    computer = 10;
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
