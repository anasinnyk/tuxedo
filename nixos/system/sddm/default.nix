{ lib, ... }:
{
  services.xserver.displayManager.sddm.sugarCandyNix = {
    enable = true;

    settings = {
      Background = lib.cleanSource ./../../home-manager/hyprland/wallpaper.jpg;
      PartialBlur = true;
      FormPosition = "left";
      Font = "JetBrains Mono";
      HeaderText = "welcome /home";
      AccentColor = "#b8bb26;";
    };
  };
}
