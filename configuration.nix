{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  
  system.stateVersion = "25.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;


  # boot
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 2;
    # systemd-boot.memtest86.enable = true;

    efi.canTouchEfiVariables = true;
    timeout = null;
  };
  
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # network
  networking.hostName = "germaine";
  networking.networkmanager.enable = true;


  # general
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "fr_FR.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings.LC_TIME = "fr_FR.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  services.libinput.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;


  # display
  services.displayManager.lemurs.enable = true; # display manager
  security.pam.services.swaylock = {};          # lock screen
  hardware.acpilight.enable = true;             # backlight
  programs.niri.enable = true;                  # wayland compositor

  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-gnome ];

  
  # sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


  # fru 🦋
  users.groups.fruit = {};
  users.users.fruit = {
    isNormalUser = true;
    group = "fruit";
    extraGroups = [
      "wheel"
      "seat"
      "docker"
      "networkmanager"
      "video"
      "audio"
      "pipewire"
      "realtime"
    ];

    shell = pkgs.fish;
  };


  # programs
  programs.fish.enable = true;
  programs.nushell.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    curl
    git
    gzip
    nil
    xwayland-satellite
  ];

  users.users.fruit.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
    bibata-cursors
    quickshell
    swaybg
    xwayland-satellite

    dolphin
    nnn
    firefox
    nsxiv
    vlc
    obs-studio
    inkscape
    vesktop

    qbittorrent
    nicotine-plus
  ];
  

  services.flatpak.enable = true;
  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;
}
