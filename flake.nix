{
  description = "A fix for the biggest mistake in human history.";

  # inputs.nixpkgs.url = "git+https://github.com/nixos/nixpkgs";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nvim.url = "/home/mt/FLAKE-NVIM";

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
      # pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      # packages.${system}.default = inputs.nixpkgs.lib.nixosSystem { inherit inputs.self pkgs system; };
      nixosConfigurations = {
        # arbitrary key "nixos" is considered the "default" (inconsistancy bug)
        nixos = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            myPkgs = import ./myPkgs { inherit pkgs; };
          };
          modules = [
            ./system/alacritty/alacritty.nix
            ./system/binutils.nix
            ./system/boot.nix
            ./system/chromium.nix
            ./system/cron-timers.nix
            ./system/eww
            ./system/fish.nix
            ./system/glow.nix
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
    # pkgs.neovide
  ];

})


({ pkgs, ... }:

{

  environment.systemPackages = [
    pkgs.caddy
    pkgs.git
    pkgs.pavucontrol
    pkgs.mpv
  ];

})

	  ];
        };
      };
    };
}
