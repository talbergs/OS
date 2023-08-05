{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.xdg-utils
  ];
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Images";
      videos = "${config.home.homeDirectory}/Videos";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/bmp" = ["swayimg.desktop"];
        "image/gif" = ["swayimg.desktop"];
        "image/jpeg" = ["swayimg.desktop"];
        "image/jpg" = ["swayimg.desktop"];
        "image/pjpeg" = ["swayimg.desktop"];
        "image/png" = ["swayimg.desktop"];
        "image/svg+xml" = ["swayimg.desktop"];
        "image/tiff" = ["swayimg.desktop"];
        "image/webp" = ["swayimg.desktop"];
        "image/x-bmp" = ["swayimg.desktop"];
        "image/x-emf" = ["swayimg.desktop"];
        "image/x-freehand" = ["swayimg.desktop"];
        "image/x-ico" = ["swayimg.desktop"];
        "image/x-pcx" = ["swayimg.desktop"];
        "image/x-png" = ["swayimg.desktop"];
        "image/x-portable-anymap" = ["swayimg.desktop"];
        "image/x-portable-bitmap" = ["swayimg.desktop"];
        "image/x-portable-graymap" = ["swayimg.desktop"];
        "image/x-portable-pixmap" = ["swayimg.desktop"];
        "image/x-tga" = ["swayimg.desktop"];
        "image/x-wmf" = ["swayimg.desktop"];
        "image/x-xbitmap" = ["swayimg.desktop"];
        "image/xpm" = ["swayimg.desktop"];
      };
    };
  };
}
