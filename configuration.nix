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



  # sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };



  # users
  users.defaultUserShell = pkgs.fish;
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
      "realtime"
      "pipewire"
    ];
    useDefaultShell = true;
  };



  # display
  services.displayManager.lemurs.enable = true; # display manager
  security.pam.services.swaylock = {};          # lock screen
  # hardware.acpilight.enable = true;             # backlight
  programs.niri.enable = true;                  # wayland compositor

  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-gnome ];



  # programs
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
  
  # todo: ??
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [ git xwayland-satellite lm_sensors ];
}
