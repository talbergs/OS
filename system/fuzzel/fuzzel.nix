{ config, pkgs, ... }:

let
fuzzel-wrapped = pkgs.symlinkJoin {
  name = "fuzzel-wrapped";
  paths = [ pkgs.fuzzel ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/fuzzel \
      --add-flags '--config /etc/fuzzel.ini'
  '';
};

in

{

  config.environment.systemPackages = [
    fuzzel-wrapped
  ];

  config.environment.etc."fuzzel.ini".source = ./fuzzel.ini;

}
