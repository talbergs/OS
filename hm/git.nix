{ ARGS, ... }: {

  programs.git = {
    enable = true;
    difftastic.enable = true;
    userName = "${ARGS.username}";
    userEmail = "${ARGS.email}";
    signing = {
      signByDefault = false;
      key = "AA1BA03FFF02700DFD836BD325B242ED74B61B15";
    };
  };
}
