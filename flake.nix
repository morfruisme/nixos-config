{ 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { nixpkgs, home-manager, ... }@inputs:
    let system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system}; in {

    nixosConfigurations.germaine = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        {
          nixpkgs.overlays = [
            (final: prev: {
              quickshell = inputs.quickshell.packages.${system}.default;
            })
          ];
        }
        
        ./configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.fruit = {
              imports = [ ./home.nix ];
            };
          };
        }
      ];
    };

    devShells.${system} = import ./devshells.nix { inherit pkgs; };
  };
}
