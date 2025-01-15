let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
in pkgs.mkShell ({
  name = "elm-test";

  buildInputs = with pkgs; [ elmPackages.elm elmPackages.elm-test nodejs_22 ];
})
