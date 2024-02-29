{
  description = "Nas1k's Tuxedo NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.35.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      tuxedo = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };

        modules = [
          ./nixos/system/hardware-configuration.nix
          ./nixos/system/configuration.nix
          ./nixos/system/users/nas1k.nix
          ./nixos/system/gdm
          ./nixos/system/yubico
        ];
      };
    };
    homeConfigurations.nas1k = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        inputs.sops-nix.homeManagerModules.sops
        ./nixos/home-manager
        ./nixos/home-manager/git
        ./nixos/home-manager/terminal
        ./nixos/home-manager/hyprland
        ./nixos/home-manager/kube
        ./nixos/home-manager/nvim
      ];
    };
  };
}
