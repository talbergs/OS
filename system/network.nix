{ config, pkgs, ... }:

{

  config.networking.hostName = "nixos";
  config.networking.networkmanager.enable = true;
  config.users.users.mt.extraGroups = [ "networkmanager" ];

  config.environment.systemPackages = [
    pkgs.traceroute
    pkgs.nmap
    pkgs.bind # that's gives also the "dig" utility
  ];

}
