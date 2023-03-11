_:

{

  boot.kernel.enable = true;
  # boot.kernelPackages = pkgs.linuxKernel.kernels.linux_6_1; # TODO: some issue here?
  system.stateVersion = "22.11";
  system.nixos.label = "flat-refactor";
  system.nixos.tags = [ "please" ];

}
