{ pkgs, ... }:

# Home-manager config shared between NixOS and nix-darwin hosts.
# Platform-specific bits live in home-linux.nix / home-darwin.nix.

{
  imports = [
    programs/btop.nix
    programs/fzf.nix
    programs/git.nix
    programs/kitty.nix
    programs/nixvim/nixvim.nix
    programs/ranger.nix
    programs/tmux.nix
  ];

  home.packages = with pkgs; [
    claude-code # Claude code
    eslint_d # JS/JSX linter
    fastfetch # System information display
    fd # File finder
    ffmpeg # Image processing
    imagemagick # Image conversion
    jq # CLI JSON processor
    ncdu # Disk storage utility
    nil # Nix language server
    nixfmt # Nix formatter
    nodejs # Node.js
    pre-commit # Git pre-commit hook manager
    prettier # General formatter
    ripgrep # Search tool
    ruff # Python linter/formatter
    tldr # Quick manuals
    tree-sitter # Parser generator tool
    unzip # Unzip utility
    uv # Python package manager
    zip # Zip file tools
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    ssh = "kitten ssh"; # Fix terminfo issues when SSHing from kitty
  };

  # Fix warning regarding a reference to a store path without a proper context
  manual.manpages.enable = false;
}
