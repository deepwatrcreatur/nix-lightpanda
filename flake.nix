{
  description = "Nix package for Lightpanda - headless browser for AI agents";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = self.packages.${system}.lightpanda;
          lightpanda = pkgs.callPackage ./package.nix { };
        }
      );

      overlays.default = final: prev: {
        lightpanda = self.packages.${prev.system}.lightpanda;
      };
    };
}
