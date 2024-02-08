{
  description = "Nas1k's Tuxedo NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.35.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center.url = "github:snowfallorg/nix-software-center";
     
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
          inputs.sddm-sugar-candy-nix.nixosModules.default
          ./nixos/system/sddm
          inputs.darkmatter-grub-theme.nixosModule
          ./nixos/system/grub
        ];
      };
    };
    homeConfigurations.nas1k = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        {
          home.packages = [
            inputs.nix-software-center.packages.${system}.nix-software-center
          ];
        }
        inputs.flatpaks.homeManagerModules.default
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
