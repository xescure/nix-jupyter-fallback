{
  description = "A development shell for Python projects";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = (pkgs.buildFHSUserEnv {
          name = "fhspython";
          targetPkgs = (pkgs: [
            # pkgs.poetry
            pkgs.python310
            pkgs.python310Packages.pip
            pkgs.python310Packages.virtualenv
            # pkgs.python310Packages.jupyter
            # pkgs.python310Packages.ipython
            # pkgs.cudaPackages.cudatoolkit
          ]);
            # (with pkgs; [
            #   poetry
            #   python310
            #   # cudaPackages.cudatoolkit
            # ]);
          runScript = "bash";
        }).env;
        # devShells.default = pkgs.mkShell {
        #   buildInputs = [ pkgs.poetry ] ++ [
        #     (pkgs.python310.withPackages (ps:
        #       with ps; [
        #         ps.jupyter
        #         ps.ipython

        #         # ps.pandas
        #         # ps.numpy
        #         # ps.matplotlib
        #         # ps.keras
        #         # ps.tensorflow
        #       ]))
        #   ];
        # };
      });
}
