{ ... }:
{
  services.xserver.displayManager = {
    defaultSession = "hyprland";
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
