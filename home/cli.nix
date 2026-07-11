{ ... }:

{
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
}
