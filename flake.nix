{
  description = "A collection of blocklist packaged in Nix.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    "blocklist:stevenblack" = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };

    "blocklist:adguard" = {
      url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
      flake = false;
    };

    "blocklist:nextdns" = {
      url = "github:nextdns/cname-cloaking-blocklist";
      flake = false;
    };

    "blocklist:adaway" = {
      url = "github:adaway/adaway.github.io";
      flake = false;
    };

    "blocklist:easylist" = {
      url = "github:easylist/easylist";
      flake = false;
    };

    "blocklist:peterlowe" = {
      url = "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml";
      flake = false;
    };

    "blocklist:danpollock" = {
      url = "https://someonewhocares.org/hosts/hosts";
      flake = false;
    };

    "blocklist:oisd" = {
      url = "https://dblw.oisd.nl";
      flake = false;
    };

    "blocklist:oisd-basic" = {
      url = "https://dblw.oisd.nl/basic";
      flake = false;
    };

    "blocklist:oisd-extra" = {
      url = "https://dblw.oisd.nl/extra";
      flake = false;
    };
  };

  outputs = inputs @ {flake-parts, ...}: let
    lib = import ./lib inputs.nixpkgs.lib;
  in
    flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {inherit lib;};
    } {
      imports = [
        ./flake
      ];
      systems = import inputs.systems;
    };
}
