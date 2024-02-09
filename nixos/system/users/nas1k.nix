{ pkgs, ... }:
{
  programs.zsh.enable = true;
  security.polkit.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "nas1k" ];
  users.users.nas1k = {
    isNormalUser = true;
    home = "/home/nas1k";
    shell = pkgs.zsh;
    description = "Andrii Nasinnyk";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
