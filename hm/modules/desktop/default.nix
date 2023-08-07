pkgs:
let
  sound-bin = import ../sound/bin/default.nix pkgs;
in
import ./waybar/default.nix { inherit sound-bin; }
