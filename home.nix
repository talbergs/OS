{ pkgs, myPkgs, ... }: {

  home.stateVersion = "21.05";

  imports =
  import ./hm/modules/default.nix pkgs ++
  # import ./hm/default.nix pkgs ++
  [
    ./hm/git.nix
    ./hm/alacritty.nix
    ./hm/sway.nix
    ./hm/mpv.nix
    ./hm/mime.nix
    ./hm/eww.nix
  ];

  home.packages = [
    myPkgs.please-cli
    myPkgs.fkill
    pkgs.swayimg
    pkgs.silver-searcher # ag
    pkgs.jq
    pkgs.jd-diff-patch # jd
    pkgs.tree
    pkgs.entr
    pkgs.busybox
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Colloid";
      package = pkgs.colloid-gtk-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
  };

}
