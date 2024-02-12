{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    home.username = "nas1k";
    home.homeDirectory = "/home/nas1k";

    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      busybox
      sioyek
      firefox
      hello
      fzf
      via
      jq
      yq-go
      ripgrep
      eza
      bat
      btop
      zoom-us
      blueman
      networkmanagerapplet
      youtube-music
      slack
      gnome.file-roller
      _1password-gui
      _1password
      unzip
      vlc
      httpie
      whois
      discord
      telegram-desktop
      signal-desktop
      neofetch
    ];
}
