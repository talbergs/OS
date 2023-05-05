{ ARGS, pkgs, ... }: {

  home.stateVersion = "21.05";
  home.file = {".xxx".text = ''asdasdasd3'';};

  programs.git = {
        enable = true;
        userName = "virchau13";
        userEmail = "${ARGS.email}@hexular.net";
        signing = {
            signByDefault = false;
            key = "AA1BA03FFF02700DFD836BD325B242ED74B61B15";
        };
    };
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