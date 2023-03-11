{ nixpkgs, ... }:
{
  user = "mt";
  system = "x86_64-linux";
  # TODO: it also picks up files with suffix "nix_"
  nixFilesRecursive = dir:
    nixpkgs.lib.filter
      (p: nixpkgs.lib.hasSuffix "nix" p)
      (nixpkgs.lib.filesystem.listFilesRecursive dir);
}
