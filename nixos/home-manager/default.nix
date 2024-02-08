{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    home.username = "nas1k";
    home.homeDirectory = "/home/nas1k";

    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      sioyek
      firefox
      hello
      fzf
      jq
      yq-go
      ripgrep
      eza
      bat
      btop
      zoom-us
      blueman
      youtube-music
      slack
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
