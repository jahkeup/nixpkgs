{ stdenv, fetchFromGitHub, autoreconfHook, automake, pkgconfig, cunit, check, mandoc, doxygen, libossp_uuid, zlib, libtool }:

stdenv.mkDerivation {
  pname = "zeroskip";
  version = "TODO";

  src = fetchFromGitHub {
    name = "zeroskip-source";
    rev = "978962d90f16ec8b5be2cb8dfb8b04aa8c0e41aa";
    owner = "cyrusimap";
    repo = "zeroskip";
    hash = "sha256-INSGuO3GiKuw8Da1XMCVq0SiKCcyp06lg+LHgYN5d0Q=";
  };

  #configureFlags = [ "--help" ];
  configureFlags = [ "--enable-benchmark=no" ];

  patches = [ ./use-crc32c-polyfill-func.patch ./unexport-nonportable-symbols.patch ];

  nativeBuildInputs = [
    cunit
    mandoc
    doxygen
    autoreconfHook
    automake
  ];

  buildInputs = [
    libossp_uuid
    check
    zlib
    pkgconfig
  ];

  outputs = [ "dev" "out" ];

  checkInputs = [
    cunit
    check
  ];

  doCheck = stdenv.isLinux;
}
