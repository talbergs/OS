{ ARGS, config, pkgs, ... }:

{

  # config.programs.git.enable = true;
  # config.programs.git.userEmail = "asd@asd.sda";
  # config.programs.git.userName = "MT";

  # # TODO: difftastic
  config.environment.systemPackages = [
    pkgs.git
    pkgs.caddy
    pkgs.pavucontrol
    pkgs.mpv
  ];

}
