{ inputs, config, paks, ... }:
{
  imports = [
    inputs.sddm-sugar-candy-nix.nixosModules.default
  ];
  services.xserver.displayManager.sddm.sugarCandyNix.enable = true;
}
