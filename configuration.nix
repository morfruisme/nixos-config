{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  
  system.stateVersion = "25.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  

  # boot
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 2;
    systemd-boot.memtest86.enable = true;

    efi.canTouchEfiVariables = true;
    timeout = null;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;


  # exfat partition shared with windows
  fileSystems."/media" = {
    device = "/dev/disk/by-label/media";
    fsType = "exfat";
    options = [
      "uid=1000"
      "gid=999"
      "umask=022"
      "nofail"
      "x-systemd.automount"
      "x-systemd.device-timeout=5s"
    ];
  };


  # network
  networking.hostName = "madeleine";
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
  programs.niri.enable = true;                  # wayland compositor

  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-gnome ];


  # sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  # fru 🦋
  users.groups.fruit = {};
  users.users.fruit = {
    isNormalUser = true;
    group = "fruit";
    extraGroups = [
      "wheel"
      "seat"
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
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    curl
    git
    gzip
    nil
  ];

  users.users.fruit.packages = with pkgs; [
    nerd-fonts.dejavu-sans-mono
    bibata-cursors
    quickshell
    swaybg
    xwayland-satellite

    dolphin
    nnn
    helium
    firefox
    nsxiv
    vlc
    obs-studio
    inkscape
    godot
    vesktop

    qbittorrent
    nicotine-plus

    rusty-path-of-building
  ];
}
