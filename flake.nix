{
  description = "A fix for the biggest mistake in human history.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvim.url = "git+file:///home/mt/FLAKE-NVIM";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import ./pkgs.nix { inherit inputs system; };
    in
    {
      apps = import ./apps.nix { inherit inputs system pkgs; };
      nixosConfigurations = import ./nixos-conf.nix { inherit inputs system pkgs; };
    };
}
