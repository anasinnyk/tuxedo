{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerdfonts
    font-awesome
    dunst
    eww-wayland
    waybar
    swww
    playerctl
    pamixer
    wofi
    wl-clipboard
    polkit_gnome
    hyprland-protocols
    hyprlang
    libdrm
    pipewire
    sdbus-cpp
    wayland-protocols
    xdg-desktop-portal-hyprland
    wirelesstools
    pulseaudio
    upower
    brillo
    watchexec
    pavucontrol
  ];

  xdg.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs.waybar = {
    enable = true;
    settings = [(builtins.fromJSON (builtins.readFile ./waybar/config.json))];
    style = ./waybar/style.css;
  };

  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland.conf);
  };
}
