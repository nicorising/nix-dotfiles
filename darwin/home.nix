{ ... }:

{
  imports = [
    ../home-common.nix
  ];

  home = {
    username = "nico";
    homeDirectory = "/Users/nico";
    stateVersion = "25.05";
  };
}
