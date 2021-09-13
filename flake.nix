{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs:
  let
    system = "x86_64-linux";
    overlays = [

    ]; in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          {
            nixpkgs = {
              inherit overlays;
              config.allowUnfree = true;
            };
          }
          ./system
          #home-manager.nixosModules.home-manager {
          #  home-manager = {
          #    useGlobalPkgs = true;
          #    useUserPackages = true;
          #    users.mark = import ./home;
          #    extraSpecialArgs = {
          #      inherit inputs;
          #    };
          #  };
          #}
        ];
      };
    };
  }
