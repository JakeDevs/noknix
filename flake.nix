{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
      ironbar = {
    url = "github:JakeStanger/ironbar";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.jake = ./home-manager/home.nix;
                useUserPackages = true;
              };
            }
          ];
        };
      };
    };
}

