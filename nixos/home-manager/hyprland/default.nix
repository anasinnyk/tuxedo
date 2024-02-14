{ pkgs, ... }:
let
  gruvbox = import ./pkgs/gruvbox-plus.nix { inherit pkgs; };
  flameshot = pkgs.flameshot.overrideAttrs (old: {
    version = "next";

    src = pkgs.fetchFromGitHub {
      owner = "flameshot-org";
      repo = "flameshot";
      rev = "master";
      sha256 = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
    };

    NIX_CFLAGS_COMPILE = "-DUSE_WAYLAND_GRIM=ON";
  });
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
    wl-clip-persist
    polkit_gnome
    libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
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
    xdg-desktop-portal-wlr
    wirelesstools
    pulseaudio
    upower
    brillo
    watchexec
    brightnessctl
    pavucontrol
    mako
    swaynotificationcenter
    bibata-cursors
    adw-gtk3
    gnome.adwaita-icon-theme
    polkit_gnome
  ];

  services.flameshot = {
    enable = true;
    package = flameshot;
  };

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  home.file.".local/share/icons/Bibata-Modern-Ice".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice";
  gtk.iconTheme.name = "Gruvbox-Plus-Dark";
  home.file.".local/share/icons/Gruvbox-Plus-Dark".source = "${gruvbox}/Gruvbox-Plus-Dark";
  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3";
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = true;
  };
  gtk.gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = true;
  };
  home.sessionVariables.GTK_THEME = "adw-gtk3";
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
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
