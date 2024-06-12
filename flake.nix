{
  description = "A development shell for Python projects";

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-24.05"; # You can adjust the nixpkgs version as needed
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.poetry ] ++ [
            (pkgs.python310.withPackages (ps:
              with ps; [
                ps.jupyter
                ps.ipython

                # ps.pandas
                # ps.numpy
                # ps.matplotlib
                # ps.keras
                # ps.tensorflow
              ]))
          ];
        };
      });
}
