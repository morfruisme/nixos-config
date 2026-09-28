{ 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, home-manager, ... }@inputs:
    let system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system}; in {

    nixosConfigurations.madeleine = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        {
          nixpkgs.overlays = [
            inputs.helium.overlays.default
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


    # devshells
    devShells.${system} = {
      c = pkgs.mkShell {
        packages = with pkgs; [
          gcc
          clang-tools
          gnumake
        ];
      };

      haskell = pkgs.mkShell {
          packages = with pkgs.haskellPackages; [
          ghc
          haskell-language-server
        ];
      };

      python = pkgs.mkShell {
        packages = pkgs.python3.withPackages (pkgs: with pkgs; [
          numpy
          pillow
          pip
          python-lsp-server
        ]);
      };
    };
  };
}
