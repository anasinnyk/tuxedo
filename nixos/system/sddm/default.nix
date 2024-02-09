{ lib, ... }:
{
  services.xserver.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      enableHidpi = true;
      wayland.enable = true;
      settings = {

      };
      sugarCandyNix = {
        enable = true;

        settings = {
          Background = lib.cleanSource ./../../home-manager/hyprland/wallpaper.jpg;
          PartialBlur = true;
          FormPosition = "left";
          Font = "JetBrains Mono";
          HeaderText = "welcome /home";
          AccentColor = "#b8bb26";
        };
      };
    };
  };
}
