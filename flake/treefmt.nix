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
        (curr: acc: acc // (enable curr))
        {}
        tools;
    };
  };
}
