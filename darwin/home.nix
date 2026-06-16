{ pkgs, ... }:

{
  imports = [
    ../home-common.nix
  ];

  home = {
    username = "nrising";
    homeDirectory = "/Users/nrising";

    packages = with pkgs; [
      awscli2
      postgresql_16
      postman
    ];

    file.".aerospace.toml".source = ../programs/aerospace.toml;

    stateVersion = "25.05";
  };

  programs.zsh.enable = true;
}
