{
  nixConfig = {
    extra-substituters = "https://ocaml.nix-cache.com";
    extra-trusted-public-keys = "ocaml.nix-cache.com-1:/xI2h2+56rwFfKyyFVbkJSeGqSIYMC/Je+7XXqGKDIY=";
  };

  inputs = {
    nixpkgs.url = github:nix-ocaml/nix-overlays;

    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.inputs.flake-utils.follows = "flake-utils";

    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs = { nixpkgs, flake-utils, nix-filter, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          system = system;
        }).appendOverlays [
          (import ./nix/overlays.nix)
        ];

        our_packages = pkgs.callPackage ./nix { inherit nix-filter; };
      in
      {
        devShells.default = pkgs.mkShell {
          inputsFrom = [ our_packages.ocaml-nix ];
          buildInputs = with pkgs.ocamlPackages; [
            odoc
            ocamlformat
            ocaml-lsp
            dune_3
          ];
        };

        packages = our_packages // {
          default = our_packages.ocaml-nix;
          docker = pkgs.callPackage ./nix/docker.nix { inherit (our_packages) ocaml-nix; };
        };

        apps = {
          proj1 = {
            type = "app";
            program = "${our_packages.ocaml-nix}/bin/proj1";
          };

          proj2 = {
            type = "app";
            program = "${our_packages.ocaml-nix}/bin/proj2";
          };
        };
      });
}
