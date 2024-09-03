lib: let
  inherit (lib) extend;
in
  extend (_final: _prev: {
    aegis = {
      mkBlocklist = import ./mkBlocklist.nix _final;
      fromInputs = import ./fromInputs.nix _final;
    };
  })
