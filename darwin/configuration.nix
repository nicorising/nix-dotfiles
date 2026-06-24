{ ... }:

{
  system = {
    primaryUser = "nrising";
    stateVersion = 6;

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 12; # ~200ms
        KeyRepeat = 2; # ~30 Hz
      };

      dock.autohide = true;
    };

    activationScripts.postActivation.text = ''
      /usr/bin/pmset -a displaysleep 10 sleep 10
    '';
  };

  users.users.nrising = {
    name = "nrising";
    home = "/Users/nrising";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Determinate Nix handles Nix instead
  nix.enable = false;

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
