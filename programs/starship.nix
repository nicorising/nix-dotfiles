{
  programs.starship = {
    enable = true;

    settings = {
      aws.disabled = true;
      package.disabled = true;

      custom.treehouse = {
        when = ''[ -n "$TREEHOUSE_DIR" ]'';
        command = ''basename "$(dirname "$TREEHOUSE_DIR")"'';
        symbol = "🌳 ";
        shell = [ "sh" ];
      };
    };
  };
}
