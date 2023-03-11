{ pkgs, ... }:

{

  environment.systemPackages = [
    pkgs.binutils
    pkgs.silver-searcher # ag
    pkgs.jq
    pkgs.jd-diff-patch # jd
    pkgs.tree
    pkgs.entr
  ];

}

