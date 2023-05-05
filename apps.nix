{ system, pkgs, ... }:

with pkgs;
with lib;

let

  nixos-switch = pkgs.writeShellApplication {
    name = "nixos-switch";
    runtimeInputs = [ gitMinimal nixVersions.stable nixos-rebuild ];
    text = ''
      exec sudo nixos-rebuild switch --flake . "$@"
    '';
  };

  home-switch = pkgs.writeShellApplication {
    name = "home-switch";
    runtimeInputs = [ home-manager ];
    text = ''
      exec home-manager switch -b backup --flake . "$@"
    '';
  };

  use-caches = pkgs.writeShellApplication {
    name = "use-caches";
    runtimeInputs = [ cachix ];
    text = ''
      cachix use -O . nix-community
      cachix use -O . terlar
    '';
  };

in
{

  ${system} = {${getName nixos-switch} = {
    type = "app";
    program = getExe nixos-switch;
  };

  ${getName home-switch} = {
    type = "app";
    program = getExe home-switch;
  };

  ${getName use-caches} = {
    type = "app";
    program = getExe use-caches;
  };
  };

}
