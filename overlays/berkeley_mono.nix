pkgs: self: super:
let
  berkeley-mono = { stdenv, lib, fetchurl, pkgs, patchelf }:
    pkgs.stdenvNoCC.mkDerivation {
      version = "1";
      pname = "berkeley-mono";
      src = ../secrets/files/berkeley_mono;
      installPhase = ''
        runHook preInstall

        install -Dm644 $src/*.ttf -t $out/share/fonts/truetype

        runHook postInstall
      '';
    };
in
{
  berkeley-mono = pkgs.callPackage berkeley-mono { };
}
