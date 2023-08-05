{ inputs, pkgs }:
{
  please-cli = import ./please-cli.nix { inherit inputs pkgs; };
  sway-alacritty-cwd = import ./sway-alacritty-cwd.nix { inherit inputs pkgs; };
  fkill = import ./fkill.nix { inherit inputs pkgs; };
}
