{ config, lib, ... }:

let
  # Replace cd with zoxide, but not for Claude Code
  aliasCd = shell: ''
    if [[ -z "$CLAUDECODE" ]]; then
      eval "$(${lib.getExe config.programs.zoxide.package} init ${shell} --cmd cd)"
    fi
  '';
in
{
  programs = {
    zoxide = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

    # Make sure zoxide appears in the config files last
    bash.initExtra = lib.mkOrder 2000 (aliasCd "bash");
    zsh.initContent = lib.mkOrder 2000 (aliasCd "zsh");
  };
}
