# https://www.reddit.com/r/NixOS/comments/ym67ly/refactor_a_nixos_configuration_and_visualize/

## FOR SECRETS
# https://github.com/ryantm/agenix

## MASTER GUY DOTFILES
# https://github.com/MatthewCroughan/nixcfg

## Quick neovim for nix
# nix shell github:kranzes/nix-config#neovim

# On how to clean install
# https://github.com/IllustratedMan-code/nixconfig

```sh
# nix search <installable> <regex>
nix search github:NixOS/nixpkgs htop
```

# Manage _quick_ packages that are kept outside this configuration.
## Nix-env installed packages will shadow packages under same name in config.

```sh
nix-env -q # list installed
nix-env -e htop # unistall
nix-env -u htop # upgrade
nix-env -i htop # install
```

```sh
# what
nix-env --list-generations
# and SYSTEM generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

Thank you!
- https://gvolpe.com/blog/neovim-meets-nix-flakes/
- https://github.com/Quoteme/neovim-flake
- https://github.com/zmre/pwnvim !!!
- https://github.com/danth/stylix
- https://github.com/Gerg-L/nvim-flake
- https://github.com/balsoft/nixos-config
- https://github.com/MayNiklas/nixos
- https://github.com/niksingh710/NixConfig
- https://github.com/yurrriq/dotfiles
- https://gist.github.com/ingenieroariel/fc9b10987d8d43c9535487f12d93e4b5

Beauty:
- https://github.com/yxqsnz/fluffy/blob/0605f066aa14eeb81e30a7c38ba7696a2e2555ec
