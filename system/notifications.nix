{ config, pkgs, ... }:

{

  config.environment.systemPackages = [
    pkgs.libnotify
    pkgs.mako
  ];

  config.services.dbus.implementation = "broker";

  config.services.dbus.packages = [
    pkgs.mako
  ];

  config.systemd.packages = [
    pkgs.mako
  ];

  config.systemd.services.mako = {

    enable = true;

    unitConfig = {
      Description = "Lightweight Wayland notification daemon";
      Documentation = "man:mako(1)";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
    };

    serviceConfig = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecCondition = ''/bin/sh -c "[ -n "$WAYLAND_DISPLAY" ]"'';
      ExecStart = "${pkgs.mako}/bin/mako";
      ExecReload = "${pkgs.mako}/bin/makoctl reload";
    };

    wantedBy = [ "graphical-session.target" ];

  };

}
