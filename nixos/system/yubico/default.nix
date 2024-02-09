{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    pam_u2f
    yubico-pam
    yubikey-manager
    yubioath-flutter
    pamtester
  ];

  services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.pam = {
    u2f = {
      enable = true;
      cue = true;
      control = "sufficient";
    };
    services = {
      greetd.u2fAuth = true;
      sudo.u2fAuth = true;
      swaylock.u2fAuth = true;
      sddm.u2fAuth = true;
    };
  };
}
