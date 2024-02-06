{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.users.nas1k = {
    home.username = "nas1k";
    home.homeDirectory = "/home/nas1k";

    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      firefox
      hello
      fzf
      jq
      yq-go
      ripgrep
      eza
      bat
      btop
      gcc_multi
      zig
      zoom-us
      youtube-music
      slack
      _1password-gui
      _1password
      unzip
      vlc
      httpie
      whois
      telegram-desktop
      signal-desktop
      neofetch
    ];

    programs.home-manager.enable = true;

    imports = [
      ./git
      ./terminal
      ./hyprland
      ./kube
      ./nvim
    ];
  };

}
