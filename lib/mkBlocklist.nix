lib: let
  inherit (lib.aegis) fromInputs;
  inherit
    (builtins)
    attrNames
    attrValues
    elem
    readFile
    mapAttrs
    ;

  inherit
    (lib)
    checkListOfEnum
    filterAttrs
    fold
    ;

  getBlocklist = name: value:
    if (elem name ["oisd" "oisd-basic" "oisd-extra" "danpollock" "peterlowe" "adguard"])
    then (readFile "${value.src}")
    else if (elem name ["nextdns"])
    then (readFile "${value.src}/domains")
    else if (name == "adaway")
    then (readFile "${value.src}/hosts.txt")
    else if (name == "stevenblack")
    then (readFile "${value.src}/hosts")
    else "";
in
  {
    inputs,
    enabledSources ? [
      "stevenblack"
      "adguard"
      "nextdns"
      "adaway"
      "easylist"
      "peterlowe"
      "danpollock"
      "oisd"
      "oisd-extra"
    ],
  }: let
    sources = fromInputs {
      inherit inputs;
      prefix = "blocklist:";
    };

    validSources = attrNames sources;

    blocklists = mapAttrs getBlocklist (filterAttrs (name: _value: elem name enabledSources) sources);
  in
    checkListOfEnum "blocklists" validSources enabledSources
    fold (curr: acc: ''
      ${acc}
      ${curr}
    '')
    ''''
    (attrValues blocklists)
