{ stdenv
, lib
, fetchurl
, system
, autoPatchelfHook
}:
stdenv.mkDerivation rec {
  pname = "ghtup";
  version = "0.1.20.0";

  src = fetchurl {
    url = "https://downloads.haskell.org/~ghcup/${version}/${system}-ghcup-${version}";
    hash = "sha256-BjSrYMZZqxTatPc9jumn+0xOLpWUBtx07ZZ3gd95ij0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    install -m755 -D $src $out/bin/ghcup
    mkdir -p $out/share/ghcup
    runHook postInstall
  '';

  GHCUP_USE_XDG_DIRS = "1";
  PATH = [ "$HOME/.ghcup/bin" ];

  meta = with lib; {
    homepage = "https://www.haskell.org/ghcup/";
    description = "GHCup is a simple installer for the Glasgow Haskell Compiler";
    platforms = platforms.linux;
  };
}
