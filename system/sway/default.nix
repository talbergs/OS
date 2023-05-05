# TODO: https://github.com/jirutka/swaylock-effects
{ config, pkgs, ... }:

{

  config.programs.sway.enable = true;
  # config.programs.sway.wrapperFeatures.gtk = true;

  config.xdg.portal.enable = true;
  config.xdg.portal.wlr.enable = true;
  config.xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-kde
  ];
  config.xdg.portal.wlr.settings = {
  };

  config.programs.sway.extraOptions = [
    "--config"
    "/etc/sway.config"
  ];

  # TODO: split these out
  config.environment.systemPackages = with pkgs; [
    dbus
    transmission-gtk
    # < THEMES
    mojave-gtk-theme
    rose-pine-gtk-theme
    pop-gtk-theme
    colloid-gtk-theme
    flat-remix-gtk
    # </THEMES
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xdg-desktop-portal-kde
    qt4
    wayland
    wl-clipboard
    wl-clipboard-x11
    discord
    glib # gives: gsettings, and more
    palenight-theme
    colloid-gtk-theme
    gsettings-desktop-schemas
    # pkgs.amarena-theme

    cinnamon.nemo
  ];

  config.environment.variables = {
    GTK_THEME = "Flat-Remix";
    GDK_BACKEND = "wayland";
  };

  # TODO: pass in the correct fuzzel and other binaries referenced in other config places.
  config.environment.etc."sway.config".text = import ./sway.config.nix {};

}
