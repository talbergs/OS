{ ARGS, ... } :

let un = ARGS.username;
in
{

  users.users.${un}.isNormalUser = true;
  users.users.${un}.extraGroups = [ "wheel" ];
  users.users.${un}.initialPassword = "pass";

  services.getty.autologinUser = ARGS.username;
  # home-manager.extraSpecialArgs = { email = "xxxx"; };

  # home-manager.users.mt.imports = [ ../home2.nix ];
  # home-manager.users.mt = { pkgs, ... }: {
  #       imports = [ 
  #           ../home2.nix
  #       ];
  #   };
}
