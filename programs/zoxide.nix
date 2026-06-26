{
  programs.zoxide = {
    enable = true;

    # Replace cd with zoxide in the shell
    options = [ "--cmd cd" ];
  };
}
