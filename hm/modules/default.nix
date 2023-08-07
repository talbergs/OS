# Home manager module supports such fields:
# {
#   home.packages = [ pkgs.htop ];
#   programs.<name>.enable = true;
# }
pkgs: [
  (import ./sound pkgs)
  {
    home.packages = [ (import ./sound/bin pkgs).sound-controls2 ];
  }
  (import ./desktop pkgs)
]
