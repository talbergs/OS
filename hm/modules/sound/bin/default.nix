pkgs:
{
  toggle-mic = import ./toggle-mic.nix pkgs;
  sound-controls = "${pkgs.pavucontrol}/bin/pavucontrol";
  sound-controls2 = pkgs.writeShellScriptBin "sound-controls2" "${pkgs.pavucontrol}/bin/pavucontrol";
}
