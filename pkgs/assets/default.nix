{stdenv}:
stdenv.mkDerivation {
  pname = "laincy-assets";
  version = "0.1.0";


  src =
    builtins.filterSource
    (path: _: baseNameOf path != "default.nix")
    ./.;

  dontBuild = true;

  installPhase = ''
    mkdir $out
    cp $src/* $out -r;
  '';
}
