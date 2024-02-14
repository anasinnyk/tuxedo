{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    home.username = "nas1k";
    home.homeDirectory = "/home/nas1k";

    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      sioyek
      firefox
      zoom-us
      blueman
      networkmanagerapplet
      youtube-music
      slack
      gnome.file-roller
      _1password-gui
      _1password
      vlc
      discord
      telegram-desktop
      signal-desktop
    ];
}
