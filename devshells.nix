{ pkgs }:

{  
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
    packages = [
      (pkgs.python3.withPackages (pkgs: with pkgs; [
        numpy
        pillow
        pip
        python-lsp-server
      ]))
    ];
  };
}
