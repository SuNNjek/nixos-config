{ lib, ... }:
let 
  joinKeys = keys: lib.join "+" keys;

  toBind = {
    keys,
    bind,
    keyOptions ? {},
    bindArgs ? []
  }: {
    ${joinKeys keys} = {
      _props = keyOptions;
      _children = [
        {
          ${bind} = bindArgs;
        }
      ];
    };
  };
in 
{
  inherit toBind;
}
