_:

{

  users.users.mt.isNormalUser = true;
  users.users.mt.extraGroups = [ "wheel" ];
  users.users.mt.initialPassword = "pass";

  services.getty.autologinUser = "mt";

}
