# Various hosts configured.

{ inputs, system, ... }:
{
  # arbitrary key "nixos" is considered the "default" (inconsistancy bug)
  nixos = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs.ARGS.username = "mt";
    specialArgs.ARGS.email = "tell@noone.ever";
    modules = [
      inputs.home-manager.nixosModule
      ({ARGS, ...}:
let un = ARGS.username;
in
      {
        home-manager.extraSpecialArgs = { inherit ARGS; };
        home-manager.users.${un} = {imports = [ ./home.nix ];};
        # home-manager.users.mt = { pkgs, ... }: { imports = [ ./home.nix ]; };
      })
      ./system/alacritty/alacritty.nix
      ./system/binutils.nix
      ./system/boot.nix
      ./system/chromium.nix
      ./system/cron-timers.nix
      ./system/eww
      ./system/fish.nix
      ./system/git.nix
      ./system/glow.nix
      ./system/latex.nix
      ./system/fkill.nix
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
