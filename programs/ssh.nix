{
  programs.ssh = {
    enable = true;

    settings = {
      "nicorising.com" = {
        HostName = "nicorising.com";
        User = "nico";
        IdentityFile = "~/.ssh/nicorising_ed25519";
        IdentitiesOnly = true;
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/github_ed25519";
        IdentitiesOnly = true;
      };

      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentityFile = "~/.ssh/gitlab_ed25519";
        IdentitiesOnly = true;
      };
    };

    enableDefaultConfig = false;
  };
}
