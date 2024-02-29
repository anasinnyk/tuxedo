{ pkgs, ... }:
let
  user = "nas1k";
in
{
    nixpkgs.config.allowUnfree = true;

    home.username = user;
    home.homeDirectory = "/home/${user}";

    home.stateVersion = "24.05";

    sops.defaultSopsFormat = "yaml";
    
    sops.age.keyFile = "/home/${user}/Projects/nix/.keys/res.age";

    home.packages = with pkgs; [
      usbutils
      webcamoid
      transmission
      element-desktop
      sioyek
      firefox
      pass
      protonmail-bridge
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
