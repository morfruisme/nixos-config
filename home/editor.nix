{ lib, pkgs, ... }:

{ 
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
