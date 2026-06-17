{
  description = "My Nix configuration files";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      mac-app-util,
      nixpkgs,
      nixvim,
      nix-darwin,
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

      darwinConfigurations.nicoworktop = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/configuration.nix

          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.nrising = {
              imports = [
                ./darwin/home.nix
                mac-app-util.homeManagerModules.default
                nixvim.homeModules.nixvim
              ];
            };
          }
        ];
      };
    };
}
