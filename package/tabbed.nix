{ lib
, stdenv
, fetchFromGitHub
, xorgproto
, libX11
, libXft
, customConfig ? null
, patches ? [ ]
, ...
}:

stdenv.mkDerivation rec {
  pname = "tabbed";
  version = "69e9684";

  src = fetchFromGitHub ({
    owner = "yaocccc";
    repo = "tabbed";
    rev = "${version}";
    fetchSubmodules = false;
    sha256 = "sha256-XcwpcLaMVD1oZh6ZGm5kcMc84OvF05qIj7Lqn2LmwE4=";
  });
  buildInputs = [ xorgproto libX11 libXft ];

  makeFlags = [ "CC:=$(CC)" ];
  installFlags = [ "PREFIX=$(out)" ];
}
