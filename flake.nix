{
  description = "My Nix configuration files";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      nixvim,
      ...
    }:

    {
      nixosConfigurations.nicotop = nixpkgs.lib.nixosSystem {
        modules = [
          ./linux/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.nico = {
              imports = [
                ./linux/home.nix
                nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };

      # TODO: Replace "macbook" with the actual hostname
      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/configuration.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.nico = {
              imports = [
                ./darwin/home.nix
                nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };
    };
}
