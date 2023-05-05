{ ARGS, ... } :

{

  users.users.${ARGS.username}.isNormalUser = true;
  users.users.${ARGS.username}.extraGroups = [ "wheel" ];
  users.users.${ARGS.username}.initialPassword = "pass";

  services.getty.autologinUser = ARGS.username;
  # home-manager.extraSpecialArgs = { email = "xxxx"; };

  # home-manager.users.mt.imports = [ ../home2.nix ];
  # home-manager.users.mt = { pkgs, ... }: {
  #       imports = [ 
  #           ../home2.nix
  #       ];
  #   };
}
