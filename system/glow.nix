{ config, pkgs, ... }:

{

  config.environment.systemPackages = [
    pkgs.glow
  ];

}
