{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nicotop";
    networkmanager.enable = true;
  };

  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  users.users.nico = {
    isNormalUser = true;
    description = "Nico";
    extraGroups = [
      "audio"
      "dialout"
      "docker"
      "networkmanager"
      "wheel"
    ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  powerManagement.cpuFreqGovernor = "powersave";

  security.polkit.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # USB devices
  services.udev = {
    packages = with pkgs; [
      platformio-core.udev
      qmk
      vial
    ];
    extraRules = ''
      # Flipper Zero serial port
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", TAG+="uaccess"
      # Flipper Zero DFU
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
    '';
  };

  # Removable media
  services.udisks2.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Fingerprint reader
  services.fprintd.enable = true;
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  # Docker
  virtualisation.docker.enable = true;

  # Automatically set timezone from location
  services.automatic-timezoned.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs = {
    # Shared libraries for dynamically linked binaries
    nix-ld = {
      enable = true;

      libraries = with pkgs; [
        glib
        libGL
        libice
        libsm
        libx11
        libxcb
        libxext
        libxi
        libxkbcommon
        stdenv.cc.cc.lib
        wayland
        zlib
      ];
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 7d";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    hyprland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "start-hyprland";
        user = "nico";
      };
      default_session = initial_session;
    };
  };

  system.stateVersion = "25.05";
}
