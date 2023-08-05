{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor.thickness = 0;
      font.size = 13;
      font.normal.family = "ComicCode";
      colors.cursor = {
        text = "#000000";
        cursor = "#ff00ff";
      };
      key_bindings = [
        # {
        #   key = "T";
        #   mods = "Command";
        #   action = "SpawnNewInstance";
        # }
        # {
        #   key = "K";
        #   mods = "Control";
        #   action = "SpawnNewInstance";
        # }
      ];
    };
  };
}
