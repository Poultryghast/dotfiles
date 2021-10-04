{ pkgs, ... }:

let
  version = "2.7.3";
in pkgs.appimageTools.wrapType1 rec {
  name = "lunar";
  src = pkgs.fetchurl {
    url = "https://launcherupdates.lunarclientcdn.com/Lunar%20Client-${version}.AppImage";
    name = "lunar-client.AppImage";
    sha256 = "0ihi937rrj677y9b377b4hhp9wsarbqwrdrd6k3lhzx3jyh2fynf";
  };
}