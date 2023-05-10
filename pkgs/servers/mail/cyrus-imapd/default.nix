{ pkgs ? import ../../../.. { } }:

(pkgs.callPackage ./generic.nix { }) {
  version = "3.6.1";
  sha256 = "sha256-G+0Kz50AvkFeYLClG9tcSa1D2Bc4XxubzQJA/HnET8E=";
}
