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
      ssm-session-manager-plugin
    ];

    file.".aerospace.toml".source = ../programs/aerospace.toml;

    stateVersion = "25.05";
  };

  programs = {
    zsh.enable = true;
    kitty.font.size = 12;
  };
}
