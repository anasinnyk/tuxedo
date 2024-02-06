{ inputs, lib, ... }:
{
  imports = [
    inputs.sddm-sugar-candy-nix.nixosModules.default
  ];
  services.xserver.displayManager.sddm.sugarCandyNix = {
    enable = true;

    settings = {
      Background = lib.cleanSource ./../home-manager/hyprland/wallpaper.jpg;
      PartialBlur = true;
      FormPosition = "left";
      Font = "JetBrains Mono";
      HeaderText = "welcome /home";
    };
  };
}
