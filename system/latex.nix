{ config, pkgs, ... }:

{

  config.environment.systemPackages = [
    pkgs.tectonic
    pkgs.texlive.combined.scheme-full
    pkgs.zathura
    pkgs.sioyek # The new zathura https://sioyek.info/
  ];

}
