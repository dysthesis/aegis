{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.treefmt.flakeModule];
  perSystem = _: {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = let
        inherit (lib) fold;
        enable = name: {${name}.enable = true;};
        tools = [
          "alejandra"
          "statix"
          "deadnix"
          "prettier"
        ];
      in
        fold
        # Fold function
        (curr: acc: acc // (enable curr))
        # Accumulator
        {}
        # List to fold on
        tools;
    };
  };
}
