{ config, pkgs, ... }:

let

eww-wrapped = pkgs.symlinkJoin {
  name = "eww-wrapped";
  paths = [ pkgs.eww-wayland ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/eww \
      --add-flags '--config /etc/eww/'
  '';
};

in

{

  config.environment.etc."eww/eww.scss".text = import ./scss.nix {};
  config.environment.etc."eww/eww.yuck".text = import ./yuck.nix {
    nm-wifi-widget = import ./scripts/wifi.nix {inherit pkgs;};
    sway-keyboard-widget = import ./scripts/keyboard.nix {inherit pkgs;};
    sway-workspaces-widget = import ./scripts/workspaces.nix {inherit pkgs;};
  };
  config.environment.systemPackages = [ eww-wrapped ];

}
