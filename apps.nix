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

  nixos-switch-clean = pkgs.writeShellApplication {
    name = "nixos-switch-clean";
    runtimeInputs = [ gitMinimal nixVersions.stable nixos-rebuild ];
    text = ''
      sudo nix-collect-garbage --delete-older-than 30d
      exec sudo nixos-rebuild --install-bootloader --flake .# switch
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

  ${system} = {

    ${getName nixos-switch-clean} = {
      type = "app";
      program = getExe nixos-switch-clean;
    };

    ${getName nixos-switch} = {
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
