{ ... }:

{
  system = {
    primaryUser = "nico";
    stateVersion = 6;
  };

  users.users.nico = {
    name = "nico";
    home = "/Users/nico";
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  nix.enable = false;

  programs.zsh.enable = true;
}
