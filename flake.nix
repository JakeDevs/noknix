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

  outputs = { nixpkgs, home-manager, ... }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            users.jake = ./home-manager/home.nix;
            useUserPackages = true;
            useGlobalPkgs = true;
          };
        }
      ];
    };
  };
}
