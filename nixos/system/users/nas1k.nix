{ pkgs, ... }:
{
  programs.zsh.enable = true;
  services.blueman.enable = true;
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.blueman.network.setup" ||
            action.id == "org.blueman.dhcp.client" ||
            action.id == "org.blueman.rfkill.setstate" ||
            action.id == "org.blueman.pppd.pppconnect") &&
            subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
    '';
  };
  services.udev.packages = [
    pkgs.via
  ];
  programs._1password-gui.polkitPolicyOwners = [ "nas1k" ];
  users.users.nas1k = {
    isNormalUser = true;
    home = "/home/nas1k";
    shell = pkgs.zsh;
    description = "Andrii Nasinnyk";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
