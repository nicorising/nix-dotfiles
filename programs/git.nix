{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      rebase.autosquash = true;

      user = {
        name = "Nico Rising";
        email = "nico@nicorising.com";
      };

      alias = {
        lg = "log --graph --oneline";
        pfwl = "push --force-with-lease";
        hash = "rev-parse --short HEAD";

        # List last branches
        h = ''
          !f() {
            n=''${1:-10}
            i=0
            while [ $i -lt $n ]; do
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

  home.packages = [ pkgs.git-absorb ];
}
