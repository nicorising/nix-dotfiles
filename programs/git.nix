{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;

      user = {
        name = "Nico Rising";
        email = "nico@nicorising.com";
      };

      alias = {
        lg = "log --graph --oneline --all";
        pfwl = "push --force-with-lease";

        # List last 10 branches
        h = ''
          !f() {
            i=0
            while [ $i -lt 10 ]; do
              i=$((i + 1))
              ref=$(git rev-parse --symbolic-full-name @{-$i} 2> /dev/null) || break
              printf "@{-%d} %s\n" "$i" "$ref"
            done
          }
          f
        '';
      };
    };
  };
}
