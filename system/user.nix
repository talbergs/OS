{ ARGS, ... } :
{

  users.users.${ARGS.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "pass";
  };

  services.getty.autologinUser = ARGS.username;
}
