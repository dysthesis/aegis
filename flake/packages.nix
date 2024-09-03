{
  lib,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (lib.aegis) mkBlocklist;
    inherit (pkgs) writeText;
    inherit (pkgs.stdenv) mkDerivation;
  in {
    packages = rec {
      blocklist = mkDerivation {
        name = "blocklist";
        src = writeText "blocklist" (mkBlocklist {inherit inputs;});

        # Skip unpacking, it's just a text file
        unpackPhase = "true";

        installPhase =
          /*
          sh
          */
          ''
            mkdir -p $out
            cp $src $out/
          '';
      };
      default = blocklist;
    };
  };
}
