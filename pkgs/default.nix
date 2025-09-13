{pkgs, ...} @ args: rec {
  default = laincy-nvim;
  laincy-nvim = pkgs.callPackage ./nvim args;
  laincy-assets = pkgs.callPackage ./assets {};
}
