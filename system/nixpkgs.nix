_:

{

  nixpkgs.config.allowUnfree = true;

  nix.extraOptions = ''
    experimental-features = flakes nix-command
  '';

}
