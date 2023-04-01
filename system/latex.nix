{ config, pkgs, ... }:

{

  config.environment.systemPackages = [
    pkgs.tectonic
  ];

}
