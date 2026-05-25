{ pkgs, ... }:

let
  addScript = name: pkgs.writeShellScriptBin name (builtins.readFile ./scripts/${name}.sh);
in
{
  imports = [
    programs/btop.nix
    programs/fuzzel.nix
    programs/fzf.nix
    programs/git.nix
    programs/hypridle.nix
    programs/hyprland.nix
    programs/hyprlock.nix
    programs/kitty.nix
    programs/librewolf.nix
    programs/nh.nix
    programs/nixvim/nixvim.nix
    programs/ranger.nix
    programs/ssh.nix
    programs/thunderbird.nix
    programs/vscode.nix
    programs/waybar/waybar.nix
    programs/zathura.nix
  ];

  home = {
    username = "nico";
    homeDirectory = "/home/nico";

    packages = with pkgs; [
      alsa-utils # Advanced Linux Sound Architecture
      arduino # Electronics prototyping
      bitwarden-desktop # Password manager
      bluez
      bluez-tools
      brightnessctl # CLI screen brightness control
      capitaine-cursors-themed # Cursor theme
      chirp # Radio programming tool
      claude-code # Claude code
      clojure # Clojure
      cloudflared # Cloudflare services
      dig # DNS lookup tool
      discord
      extremetuxracer
      fastfetch # System information display
      fd # File finder
      ffmpeg # Image processing
      gcc # Compilers
      hyprshot # Screenshot tool
      inotify-tools # Tools for inotify
      jq # CLI JSON processor
      keepassxc # Password manager
      killall # Process killing command
      libnotify # Notification sender
      libreoffice
      mullvad-vpn
      ncdu # Disk storage utility
      nerd-fonts.noto # Nerd fonts
      networkmanagerapplet # GUI for advanced network settings
      nil # Nix language server
      nixfmt # Nix formatter
      nodejs # Node.js
      eslint_d # JS/JSX linter
      prettier # General formatter
      obs-studio # Video recording
      pamixer
      pandoc # File converter
      parted # Disk formatting
      pavucontrol
      pgadmin4-desktopmode # PostgreSQL GUI
      playerctl # CLI media player control
      popsicle # USB flasher
      postman # API testing tool
      prismlauncher # Minecraft launcher
      ripgrep # Search tool
      ruff # Python linter/formatter
      signal-desktop
      sl # Steam locomotive
      slack
      socat # Data relay tool
      spotify # Spotify
      steam # Steam
      super-slicer-beta # 3D printing
      awww # Wallpaper manager
      teams-for-linux
      tex-fmt # LaTeX formatter
      texliveFull # LaTeX
      tldr # Quick manuals
      tree-sitter # Parser generator tool
      qFlipper # Flipper Zero GUI
      qbittorrent
      unzip # Unzip utility
      usbutils # USB CLI tools
      uv # Python package manager
      v4l-utils # Video4Linux utilities
      vlc # Media player
      websocat # CLI for WebSockets
      waybar # Taskbar
      wev # Wayland event viewer
      wl-clipboard # Wayland clipboard CLI
      zip # Zip file tools
      zoom-us # Zoom

      (python3.withPackages (
        ps: with ps; [
          cairosvg # Image rendering
          gensim # Vector space modeling
          ipykernel # Jupyter kernel
          ipython # IPython kernel
          jupyter-client # Jupyer
          keras # Keras ML API
          matplotlib # Plotting
          mypy # Static typing
          nbformat # Notebook format support
          nltk # Natural language toolkit
          notebook # Jupyter notebook
          numpy # Math operations
          pandas # Data analysis
          pillow # Image processing
          pyarrow # Data processing
          pynvim # Python in Neovim
          tensorflow # Machine learning
          torch # PyTorch
          transformers # Transformer models
          scikit-learn # Scikit learn
          seaborn # Data visualization
          spacy # Natural language toolkit
          spacy-models.en_core_web_sm # Spacy English model
          statsmodels # Statistical models
          jupytext # Jupyter to Python conversion
        ]
      ))

      # Add custom scripts
      (addScript "bluetooth-menu")
      (addScript "hyprland-wallpapers")
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      grep = "grep --color=auto";
      ssh = "kitten ssh"; # Fix terminfo issues when SSHing from kitty
    };

    # Copy over wallpapers
    file.".local/share/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };

    pointerCursor = {
      enable = true;
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
      size = 24;
    };

    stateVersion = "25.05";
  };

  programs.bash.enable = true;

  services = {
    hyprpolkitagent.enable = true;

    # Notifications
    mako = {
      enable = true;

      settings = {
        default-timeout = 5000;
        border-radius = 4;
        border-color = "#83a598";
        text-color = "#ebdbb2";
        background-color = "#282828";
      };
    };

    udiskie = {
      enable = true;
      notify = true;
      tray = "always";
    };

    # Inter-device communication
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "NotoSerif NFP"
      ];
      sansSerif = [
        "NotoSans NFP"
      ];
      monospace = [
        "NotoSansM NFM"
      ];
    };
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
