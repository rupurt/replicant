{
  description = "Development environment for Replican. Cloud native, query based CDC orchestration for Ploomber";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    flake-utils,
    nixpkgs,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    outputs = flake-utils.lib.eachSystem systems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
      };
    in {
      # packages exported by the flake
      packages = {
      };

      # nix run
      apps = {};

      # nix fmt
      formatter = pkgs.alejandra;

      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.python3
          pkgs.poetry
        ];
      };
    });
  in
    outputs;
}
