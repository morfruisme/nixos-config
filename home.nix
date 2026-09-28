{ pkgs, ... }:

{  
  home.stateVersion = "25.11";
  home.username = "fruit"; # 🦋
  home.homeDirectory = "/home/fruit";
  programs.home-manager.enable = true;

  # git  
  programs.git = {
    enable = true;
    settings.user.name = "fruit";
    settings.user.email = "nico.travert@gmail.com";
  };
  programs.git-credential-oauth.enable = true;

  programs.jujutsu = {
    enable = true;
    settings.user.name = "fruit";
    settings.user.email = "solen.travert@gmail.com";
  };


  # lockscreen
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


  # application launcher
  programs.rofi = {
    enable = true;
    theme = "dmenu";
  };


  # cli
  programs.kitty = {  
    enable = true;
    enableGitIntegration = true;
    settings = {
      "map ctrl+shift+enter" = "new_window_with_cwd";
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      background_opacity = 0.8;
      momentum_scroll = 0;
    };
    extraConfig = "include current-theme.conf";
  };


  # editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
  
    settings.editor = {
      line-number = "relative";
      auto-format = true;

      soft-wrap = {
        enable = true;
        wrap-indicator = "";
      };

      cursor-shape = {
        normal = "block";
        insert = "block";
        select = "underline";
      };
    };

    settings.keys.normal.space = {
      f = "file_picker_in_current_directory";
      F = "file_picker";
    };

    settings.theme = "seoul256-light";
  };
}
