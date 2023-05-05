{ inputs, pkgs, config, ... }:
inputs.home-manager.nixosModules.home-manager {
  inherit pkgs config;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
