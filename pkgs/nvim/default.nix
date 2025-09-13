{
  pkgs,
  inputs,
  ...
}: let
  utils = import inputs.nixCats;
  luaPath = ./.;

  categoryDefinitions = import ./categories.nix;

  packageDefinitions = {
    nvim = {
      pkgs,
      name,
      mkPlugin,
      ...
    }: {
      settings = {
        suffix-path = true;
        suffix-LD = true;
      };

      categories = {
        general = true;
        rust = true;
        zig = true;
        cmp = true;
      };
    };
  };

  defaultPackageName = "nvim";
in
  utils.baseBuilder luaPath {inherit pkgs;} categoryDefinitions packageDefinitions defaultPackageName
