{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    ,
    }:
    let
      overlay =
        final: prev: {
          st = prev.st.overrideAttrs (oldAttrs: rec {
            version = "master";
            src = ./.;
            buildInputs =
              oldAttrs.buildInputs
              ++ [
                prev.harfbuzz
              ];
          });
          tabbed = prev.callPackage ./package/tabbed.nix { };
        };
    in
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in
        rec {
          packages = {
            st = pkgs.st;
            tabbed = pkgs.tabbed;
          };
        }
      )
    // {
      overlays.default = overlay;
    };
}
