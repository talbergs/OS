# Various hosts configured.

{ pkgs, inputs, system, ... }:
{
  # arbitrary key "nixos" is considered the "default" (inconsistancy bug)
  nixos = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs.ARGS.username = "mt";
    specialArgs.ARGS.email = "tell@noone.ever";
    specialArgs.myPkgs = import ./myPkgs {inherit inputs pkgs;};
    modules = [
      inputs.home-manager.nixosModule
      ({ARGS, myPkgs, ...}: {
        home-manager.extraSpecialArgs = { inherit ARGS myPkgs; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${ARGS.username} = {imports = [ ./home.nix ];};
      })
      ./system/boot.nix
      ./system/chromium.nix
      ./system/cron-timers.nix
      # ./system/eww
      ./system/fish.nix
      ./system/glow.nix
      ./system/latex.nix
      ./system/fonts/fonts.nix
      ./system/fuzzel/fuzzel.nix
      ./system/hardware.nix
      ./system/locale.nix
      ./system/network.nix
      ./system/nixos.nix
      ./system/nixpkgs.nix
      ./system/notifications.nix
      ./system/sound.nix
      ./system/sway
      ./system/theming.nix
      ./system/time.nix
      ./system/user.nix
    ] ++ [
      ({ pkgs, ... }:
      {
        environment.systemPackages = [
          inputs.nvim.packages.x86_64-linux.default
        ];
      })];
    };
  }
