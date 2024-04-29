{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        nixpkgs = import nixpkgs { inherit (prev) system; config.allowUnfree = true; };
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
      };
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
      hostnames = builtins.attrNames (builtins.readDir ./hosts);
    in {
      nixosConfigurations = builtins.listToAttrs (builtins.map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ overlayModule ./hosts/${host}/configuration.nix ];
        };
      }) hostnames);
    };
}
