{ stdenv, lib, pkgs, cyrus_sasl, ... }:

let
  zeroskip = pkgs.callPackage ./zeroskip { };
in

# We support
{ version, rev ? "cyrus-imapd-${version}", sha256 ? "", patches ? [ ]
, sasl ? cyrus_sasl, ... }:

stdenv.mkDerivation (finalAttrs: {
  pname = "cyrus-imapd";
  inherit version;

  src = pkgs.fetchFromGitHub {
    owner = "cyrusimap";
    repo = "cyrus-imapd";

    name = "${finalAttrs.pname}-${finalAttrs.version}-source";

    inherit rev sha256;
  };

  patches = [ ./fix-ulong.patch ./stat-field.patch ] ++ patches;

  # https://www.cyrusimap.org/3.8/imap/developer/compiling.html#required-build-dependencies
  buildInputs = [
    pkgs.xapian
    pkgs.jansson
    pkgs.wslay
    pkgs.libbsd
    pkgs.libtool
    pkgs.icu
    pkgs.libuuid
    pkgs.openssl
    pkgs.sqlite
    sasl
    pkgs.vim
    pkgs.brotli
    pkgs.libchardet
    pkgs.libical
    pkgs.libxml2
    pkgs.shapelib
    pkgs.libkrb5
    pkgs.zstd
    pkgs.zlib
    zeroskip
    pkgs.clamav
    pkgs.cunit
  ];

  configureFlags = [ "--with-krbimpl=mit" "--enable-unit-tests" ];

  CFLAGS = [ "-D_POSIX_C_SOURCE=200809L" ];

  doCheck = stdenv.isLinux;

  nativeBuildInputs = [
    pkgs.pkgconfig
    pkgs.bison
    pkgs.automake
    pkgs.flex
    pkgs.autoreconfHook
    pkgs.perl
    pkgs.sphinx
    pkgs.doxygen
  ];
})
