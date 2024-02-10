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
    swaylock-effects
    swayidle
    grimblast
    grim
    slurp
    swappy
    wlogout
    hyprshot
    cliphist
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
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
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
    polkit_gnome
  ];
  
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  home.file = {
    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  };
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  # gtk.theme.package = pkgs.adw-gtk3;
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };
  gtk.theme.name = "Adwaita:dark";
  home.file.".local/share/icons" = {
    source = gruvbox;
    recursive = true;
  };
  home.file.".config/gtk-3.0/gtk.css".source = ./pkgs/gtk-3.0/gtk.css;
  home.file.".config/gtk-3.0/gtk-dark.css".source = ./pkgs/gtk-3.0/gtk-dark.css;
  home.file.".config/gtk-4.0/gtk.css".source = ./pkgs/gtk-4.0/gtk.css;
  home.file.".config/gtk-4.0/gtk-dark.css".source = ./pkgs/gtk-4.0/gtk-dark.css;
  gtk.iconTheme.name = "Gruvbox-Plus-Dark";
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = true;
  };
  gtk.gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = true;
  };

  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gnome
    ];
    config.common.default = "gnome";
    config.hyprland.default = [ "hyprland" "gtk" "gnome" ];
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

  home.file.".config/hypr/screenlock.sh" = {
    source = ./screenlock.sh;
    executable = true;
  };

  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland.conf);
  };
}
