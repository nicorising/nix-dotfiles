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

    bash.initExtra = aliasCd "bash";
    zsh.initContent = aliasCd "zsh";
  };
}
