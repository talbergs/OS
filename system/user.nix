{ ARGS, ... } :

{

  users.users.mt.isNormalUser = true;
  users.users.mt.extraGroups = [ "wheel" ];
  users.users.mt.initialPassword = "pass";

  services.getty.autologinUser = ARGS.username;
  # home-manager.extraSpecialArgs = { email = "xxxx"; };

  # home-manager.users.mt.imports = [ ../home2.nix ];
  # home-manager.users.mt = { pkgs, ... }: {
  #       imports = [ 
  #           ../home2.nix
  #       ];
  #   };
}
