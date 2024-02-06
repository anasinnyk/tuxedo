{ pkgs, ... }:
let
  gruvbox = import ./gruvbox-plus.nix { inherit pkgs; };
in
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
    libsForQt5.polkit-kde-agent
    hyprland-protocols
    hyprlang
    libdrm
    pipewire
    wireplunmber
    sdbus-cpp
    wayland-protocols
    xdg-desktop-portal-hyprland
    wirelesstools
    pulseaudio
    upower
    brillo
    watchexec
    pavucontrol
    qt5-wayland
    qt6-wayland
    mako
    swaync
    bibata-cursors
    adw-gtk3
  ];
  
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  home.file = {
    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  };
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3";
  gtk.iconTheme.package = gruvbox;
  gtk.iconTheme.name = "GruvboxPlus";

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
