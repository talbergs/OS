{ config, pkgs, myPkgs, ... }:

{

  config.users.users.mt.shell = pkgs.fish;

  config.environment.systemPackages = [
    myPkgs.please-cli 

    # Z - that fast CD (change directory)
    # =======================
    # `zi` - jump list fzf
    # `z` - eval first jumplist
    pkgs.zoxide # https://github.com/ajeetdsouza/zoxide

    pkgs.fishPlugins.colored-man-pages # https://github.com/PatrickF1/colored_man_pages.fish

    # GENERIC COLORIZER (grc)
    # =======================
    #  Few of wrapped tools: (cat,cvs,df,diff,dig,ifconfig,ls,make,mount,mtr,netstat,ping,ps,tail,traceroute,wdiff)
    #  I.e. $ grc ping 0.0.0.0 #=> colorized ping..

    pkgs.fishPlugins.grc # https://github.com/oh-my-fish/plugin-grc
    pkgs.grc     # fzf-grc dependency http://kassiopeia.juls.savba.sk/~garabik/software/grc/README.txt

    # =Snappy async prompts=
    # pkgs.fishPlugins.tide # https://github.com/IlanCosman/tide
    # pkgs.fishPlugins.pure # https://github.com/pure-fish/pure
    # TODO: add custom aws and more widgets to TIDE, also use git-icons used by PURE prompt.

    # When a command fails it will not linger in fish history (wrong flag/value typos).
    pkgs.fishPlugins.sponge # TODO: seems not to work ..

    # Git GUI? TODO: try this out..
    # pkgs.fishPlugins.forgit # https://github.com/wfxr/forgit

    # =FZF=
    #  Ctrl+Alt+([F]iles,[V]ariables,[R]istory,[P]rocesses)
    pkgs.fishPlugins.fzf-fish # https://github.com/PatrickF1/fzf.fish
    pkgs.fd     # fzf-fish dependency
    pkgs.bat    # fzf-fish dependency
    pkgs.fzf    # fzf-fish dependency
  ];


  # TODO: try out Babelfish
  # https://github.com/bouk/babelfish
  # config.programs.fish.useBabelfish = true;

  config.programs.fish.vendor.functions.enable = true;
  config.programs.fish.enable = true;

  config.programs.fish.interactiveShellInit = ''
    function fish_greeting
      # ${pkgs.lib.getExe myPkgs.please-cli}
    end
    ${pkgs.lib.getExe pkgs.zoxide} init fish | source
  '';

  config.programs.fish.shellAbbrs = {
    d = "docker";
    v = "nvim";
    n = "nvim";
    k = "kubectl";
    # [G]it
    g = "git";
    gr = "git remote -v";
    ga = "git add";
    gR = "git rev-parse HEAD";
    gl = "git log";
    gf = "git fetch";
    gt = "git tag";
    gp = "git push";
    gc = "git commit";
    gd = "git diff";
    gst = "git status";
    gco = "git checkout";
    glog = "git log --format=fuller --first-parent --abbrev-commit";
    # [P]lease
    p = "please";
    pa = "please add";
    pd = "please do";
    pc = "please clean";

    # [N]nix
    ns = "nix search nixpkgs";

    ":c" = "wl-copy";
    "+x" = "chmod +x";
    mkdir = "mkdir -p";
    mkd = "mkdir -p";
    rmf = "rm -rf";
    ".v" = "echo TODO abbreviates to opening neovim dotfiles editor";
    ".sway" = "echo TODO abbreviates to opening sway dotfiles editor";
    ".fish" = "echo TODO abbreviates to opening fish dotfiles editor";
    ".nixos" = "echo TODO abbreviates to opening fish dotfiles editor";
    ".eww" = "echo TODO abbreviates to opening fish dotfiles editor";
    # etc .. reaching for dotfiles quickly
  };

  config.programs.fish.shellAliases = {
    # docker = "podman"
  };

  config.environment.sessionVariables.EDITOR = "nvim"; # TODO: reference that exact nvim flake binary
}
