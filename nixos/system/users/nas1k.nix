{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.nas1k = {
    isNormalUser = true;
    home = "/home/nas1k";
    shell = pkgs.zsh;
    description = "Andrii Nasinnyk";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
