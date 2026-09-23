{ pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./editor.nix
  ];
  
  home.stateVersion = "25.11";
  home.username = "fruit"; # 🦋
  home.homeDirectory = "/home/fruit";

  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    settings.user.name = "fruit";
    settings.user.email = "solen.travert@gmail.com";
  };
  programs.git-credential-oauth.enable = true;

  programs.jujutsu = {
    enable = true;
    settings.user.name = "fruit";
    settings.user.email = "solen.travert@gmail.com";
  };
  
  programs.vesktop.enable = true;
  programs.bat.enable = true;
  programs.obs-studio.enable = true;

  programs.swaylock = {  
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      indicator = true;
      clock = true;
      image = "~/Pictures/glt.jpg";
      inside-color = "00000088";
      separator-color = "00000000";
    };
  };
  
  programs.rofi = {
    enable = true;
    theme = "dmenu";
  };
 
  home.packages =
    with pkgs;
    let default = [
      bibata-cursors
      curl
      gammastep
      inotify-tools
      nautilus
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.jetbrains-mono
      nil
      pywal
      quickshell
      swaybg
      unzip
      zip
    ];
    programs = [
      godot
      helium
      inkscape
      nicotine-plus
      qbittorrent
      rusty-path-of-building
      # stremio
      # woeusb
      vlc
    ];
    in default ++ programs;
}
