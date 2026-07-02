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

    let
      commonModule = {
        nixpkgs.config = {
          allowUnfree = true;

          # TODO: Remove once no longer needed
          permittedInsecurePackages = [ "electron-39.8.10" ];
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs.flakeNixpkgs = nixpkgs;
          sharedModules = [ nixvim.homeModules.nixvim ];
        };
      };
    in
    {
      nixosConfigurations.nicotop = nixpkgs.lib.nixosSystem {
        modules = [
          ./linux/configuration.nix
          commonModule
          home-manager.nixosModules.home-manager
          { home-manager.users.nico.imports = [ ./linux/home.nix ]; }
        ];
      };

      darwinConfigurations.nicoworktop = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/configuration.nix
          commonModule
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          {
            home-manager.users.nrising.imports = [
              ./darwin/home.nix
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };
    };
}
