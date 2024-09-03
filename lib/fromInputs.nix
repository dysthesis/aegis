lib: let
  inherit
    (lib)
    mapAttrs'
    nameValuePair
    removePrefix
    filterAttrs
    hasPrefix
    ;
in
  {
    inputs,
    prefix,
    ...
  }:
    mapAttrs'
    (name: value:
      nameValuePair
      (removePrefix prefix name)
      {src = value;})
    (filterAttrs (name: _: hasPrefix prefix name) inputs)
