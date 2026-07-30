{ ... }:

let
  syncScript = builtins.readFile ./treehouse.bash;
in
{
  programs = {
    bash.initExtra = syncScript + ''
      PROMPT_COMMAND="_treehouse_sync''${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
    '';

    zsh.initContent = syncScript + ''
      autoload -Uz add-zsh-hook
      add-zsh-hook chpwd _treehouse_sync
      _treehouse_sync
    '';
  };
}
