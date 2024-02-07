{
  description = "Nas1k's Tuxedo NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    flatpaks.url = "github:GermanBread/declarative-flatpak/stable";

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, flatpaks, home-manager, ... }@inputs:
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
          inputs.sddm-sugar-candy-nix.nixosModules.default
          ./nixos/system/sddm
        ];
      };
    };
    homeConfigurations.nas1k = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        flatpaks.homeManagerModules.default
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
