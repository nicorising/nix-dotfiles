{ pkgs, config, ... }:

let
  addScript = name: pkgs.writeShellScriptBin name (builtins.readFile ./scripts/${name}.sh);
  scaleApp =
    pkg: vars:
    let
      envArgs = builtins.concatStringsSep " " (
        pkgs.lib.mapAttrsToList (k: v: ''--set ${k} "${toString v}"'') vars
      );
    in
    pkgs.symlinkJoin {
      name = pkg.pname or pkg.name;
      paths = [ pkg ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        for bin in $out/bin/*; do
          [ -e "$bin" ] && wrapProgram "$bin" ${envArgs}
        done
        if [ -d "$out/share/applications" ]; then
          for desktop in $out/share/applications/*.desktop; do
            [ -e "$desktop" ] || continue
            if [ -L "$desktop" ]; then
              target=$(readlink -f "$desktop")
              rm "$desktop"
              sed "s|${pkg}/bin|$out/bin|g" "$target" > "$desktop"
            fi
          done
        fi
      '';
    };
in
{
  imports = [
    ../home-common.nix

    ../programs/fuzzel.nix
    ../programs/hypridle.nix
    ../programs/hyprland.nix
    ../programs/hyprlock.nix
    ../programs/librewolf.nix
    ../programs/nh.nix
    ../programs/nixvim/latex.nix
    ../programs/ssh.nix
    ../programs/thunderbird.nix
    ../programs/waybar/waybar.nix
    ../programs/zathura.nix
  ];

  home = {
    username = "nico";
    homeDirectory = "/home/nico";

    packages = with pkgs; [
      alsa-utils # Advanced Linux Sound Architecture
      arduino # Electronics prototyping
      awww # Wallpaper manager
      bitwarden-desktop # Password manager
      bluez
      bluez-tools
      brightnessctl # CLI screen brightness control
      capitaine-cursors-themed # Cursor theme
      (scaleApp chirp { GDK_DPI_SCALE = "1.5"; }) # Radio programming tool
      clang-tools # CLI tools for C/C++
      clojure # Clojure
      cloudflared # Cloudflare services
      dig # DNS lookup tool
      discord
      extremetuxracer
      gcc # Compilers
      gnumake # Make
      hyprshot # Screenshot tool
      inotify-tools # Tools for inotify
      keepassxc # Password manager
      killall # Process killing command
      libnotify # Notification sender
      libreoffice
      mullvad-vpn
      nerd-fonts.noto # Nerd fonts
      networkmanagerapplet # GUI for advanced network settings
      obs-studio # Video recording
      pamixer
      pandoc # File converter
      parted # Disk formatting
      pavucontrol
      playerctl # CLI media player control
      popsicle # USB flasher
      postman # API testing tool
      prismlauncher # Minecraft launcher
      rainfrog # PostgreSQL TUI
      signal-desktop
      sl # Steam locomotive
      slack
      socat # Data relay tool
      spotify # Spotify
      steam # Steam
      super-slicer-beta # 3D printing
      teams-for-linux
      tex-fmt # LaTeX formatter
      texliveFull # LaTeX
      qFlipper # Flipper Zero GUI
      qbittorrent
      qmk # Keyboard firmware
      usbutils # USB CLI tools
      v4l-utils # Video4Linux utilities
      (scaleApp vial { QT_FONT_DPI = "144"; }) # Keyboard configuration
      vlc # Media player
      waybar # Taskbar
      websocat # CLI for WebSockets
      wev # Wayland event viewer
      wl-clipboard # Wayland clipboard CLI
      zoom-us # Zoom

      (python3.withPackages (
        ps: with ps; [
          cairosvg # Image rendering
          gensim # Vector space modeling
          ipykernel # Jupyter kernel
          ipython # IPython kernel
          jupyter-client # Jupyer
          keras # Keras ML API
          keymap-drawer # Keymap visualizer
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
          ultralytics # YOLO models
        ]
      ))

      # Add custom scripts
      (addScript "bluetooth-menu")
      (addScript "hyprland-wallpapers")
      (addScript "toggle-monitor-mirror")
    ];

    # Copy over wallpapers
    file.".local/share/wallpapers" = {
      source = ../wallpapers;
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

  programs.bash.enable = true;

  xdg.userDirs =
    let
      home = config.home.homeDirectory;
    in
    {
      enable = true;
      createDirectories = false;
      setSessionVariables = true;

      desktop = "${home}/desktop";
      documents = "${home}/documents";
      download = "${home}/downloads";
      music = "${home}/music";
      pictures = "${home}/pictures";
      publicShare = "${home}/public";
      templates = "${home}/templates";
      videos = "${home}/videos";
    };
}
