# Usage

Show what is provided:

```bash
nix flake show
```

Switch both system (NixOS) and home:
```bash
nix run .#nixos-switch
```

Switch home only:
```bash
nix run .#home-switch
```

Update all inputs:
```bash
nix flake update --commit-lock-file
```

Update a single input:
```bash
nix flake lock --update-input nixpkgs --commit-lock-file
```

# Development

Use a local input during development:
```bash
nix flake lock --override-input nixpkgs path:../nixpkgs
```
