{ stdenv, fetchFromGitHub, autoreconfHook, automake, pkgconfig, sphinx, cunit }:

stdenv.mkDerivation rec {
  pname = "wslay";
  version = "1.1.1";

  src = fetchFromGitHub {
    name = "wslay-source-${version}";

    owner = "tatsuhiro-t";
    repo = "wslay";
    rev = "release-${version}";
    sha256 = "sha256-xKQGZO5hNzMg+JYKeqOBsu73YO+ucBEOcNhG8iSNYvA=";
  };

  nativeBuildInputs = [
    autoreconfHook
    automake
    pkgconfig
    sphinx
    cunit
  ];
}
