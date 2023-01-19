{
  description = "Kiosk for USee";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    devenv.url = "github:cachix/devenv";
  };

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  inputs.seedex = {
    url = "github:fleetyards/seedex/seeds_path";
    flake = false;
  };

  outputs = { self, nixpkgs, devenv, seedex, ... }@inputs:
    let
      systems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f:
        builtins.listToAttrs (map (name: {
          inherit name;
          value = f name;
        }) systems);

      version = "${nixpkgs.lib.substring 0 8 self.lastModifiedDate}-${
          self.shortRev or "dirty"
        }";

      # Memoize nixpkgs for different platforms for efficiency.
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        });
    in {
      overlays.default = final: prev: {
        usee_kiosk = final.callPackage ({ lib, beam, rebar3, beamPackages }:
          let
            packages = beam.packagesWith beam.interpreters.erlang;
            pname = "usee_kiosk";
            src = self;
            mixEnv = "prod";

            mixDeps = import ./nix/mix.nix {
              inherit lib beamPackages;
              overrides = overrideDeps;
            };

            overrideDeps = (self: super: { });
          in packages.mixRelease {
            inherit pname version src mixEnv;

            mixNixDeps = mixDeps;

            nativeBuildInputs = [ rebar3 ];
          }) { };
      };

      packages = forAllSystems (system: {
        inherit (nixpkgsFor.${system}) usee_kiosk;
        default = self.packages.${system}.usee_kiosk;
      });

      legacyPackages = forAllSystems (system: nixpkgsFor.${system});

      devShells = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              {
                packages = with pkgs; [ mix2nix git ];
                languages.elixir.enable = true;

                pre-commit.hooks.actionlint.enable = true;
                pre-commit.hooks.nixfmt.enable = true;
                pre-commit.hooks.mixfmt = {
                  enable = false; # Broken??
                  name = "Mix format";
                  entry = "${pkgs.elixir}/bin/mix format";
                  files = "\\.(ex|exs)$";

                  types = [ "text" ];
                  language = "system";
                  pass_filenames = false;
                };
              }
              ({ config, ... }: { process.implementation = "hivemind"; })
            ];
          };
        });

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt);

      checks = forAllSystems (system: {
        devenv_ci = self.devShells.${system}.default.ci;
        usee_kiosk = self.packages.${system}.usee_kiosk;
      });
    };
}
