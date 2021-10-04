{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... } @inputs:
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
          ./src/configuration.nix
        ];
      };
    };
  }
