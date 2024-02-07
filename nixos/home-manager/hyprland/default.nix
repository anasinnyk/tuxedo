{ pkgs, ... }:
let
  gruvbox = import ./pkgs/gruvbox-plus.nix { inherit pkgs; };
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    inconsolata-nerdfont
    jetbrains-mono
    nerdfonts
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    dunst
    eww-wayland
    waybar
    swww
    playerctl
    pamixer
    wl-clipboard
    polkit_gnome
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    hyprland-protocols
    hyprland
    libdrm
    pipewire
    wireplumber
    sdbus-cpp
    wayland-protocols
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wirelesstools
    pulseaudio
    upower
    brillo
    watchexec
    pavucontrol
    mako
    swaynotificationcenter
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
  gtk.gtk3.extraCss = builtins.readFile ./gtk.css;
  gtk.gtk4.extraCss = builtins.readFile ./gtk.css;

  xdg.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "gtk";
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  programs.wofi = {
    enable = true;
    settings = {
      mode = "drun";
      allow_images = true;
    };
    style = builtins.readFile ./wofi/style.css;
  };

  programs.waybar = {
    enable = true;
    settings = [(builtins.fromJSON (builtins.readFile ./waybar/config.json))];
    style = ./waybar/style.css;
  };

  home.file.".config/waybar/mediaplayer.sh" = {
    source = ./waybar/mediaplayer.sh;
    executable = true;
  };

  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland.conf);
  };
}
