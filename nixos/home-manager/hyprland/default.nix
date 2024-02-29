{ pkgs, ... }:
let
  flameshot = pkgs.libsForQt5.callPackage ./flameshot { };
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    qmk
    via
    inconsolata-nerdfont
    jetbrains-mono
    nerdfonts
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    librsvg
    fira-code
    fira-code-symbols
    dmenu
    selectdefaultapplication
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
    wl-clip-persist
    polkit_gnome
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
    hyprland-protocols
    hyprland
    libdrm
    pipewire
    wireplumber
    sdbus-cpp
    wayland-protocols
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    wirelesstools
    pulseaudio
    upower
    brillo
    watchexec
    brightnessctl
    pavucontrol
    bibata-cursors
    gnome.gnome-tweaks
    polkit_gnome
    killall
  ];

  services.blueman-applet.enable = true;
  services.mpris-proxy.enable = true;

  services.flameshot = {
    enable = true;
    package = flameshot;
  };

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  gtk.enable = true;
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "Adwaita-dark";
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.iconTheme.name = "Gruvbox-Plus-Dark";
  gtk.iconTheme.package = pkgs.gruvbox-plus-icons;
  home.file.".config/gtk-4.0" = {
    source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0";
    recursive = true;
  };
  home.file.".config/gtk-3.0" = {
    source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0";
    recursive = true;
  };
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
  };

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
  };

  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "gtk";
    config.hyprland.default = [ "gtk" "hyprland" ];
    config.preferred.default = "gtk,hyprland";
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

  home.file.".config/wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ./hyprland.conf);
  };

  home.file.".config/dunst/dunstrc".source = ./dunst/dunstrc;

  home.file.".config/swaylock/config".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/CelticBoozer/dotfiles/master/.config/swaylock/config";
    sha256 = "sha256-jf0gaTdM4d0QWpL9X1asAcW7c7PZI02tDXtFEfgCuEw=";
  };
}
