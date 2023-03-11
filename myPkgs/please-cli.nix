{ pkgs, ... }:

let

py3-with-deps-for-please = pkgs.python3.withPackages (ps: [ ps.typer ps.rich ]);
py3-code-for-please = pkgs.fetchFromGitHub {
  rev = "390ecaeda5cad70b56f2b4ef64725c1d1a10a842";
  owner = "NayamAmarshe";
  repo = "please";
  hash = "sha256-U0wT6uZ9IV4lemMD9UVTSMvGeQ9h5l1TQ9gUiH/tlJc=";
};

in

pkgs.writeShellScriptBin "please" ''
  if [[ "add" == "$1" ]]
  then
    # Workaround the "Got unexpected extra arguments" error for `please add "My <space> task"`
    shift
    words="$@"
    ${pkgs.lib.getExe py3-with-deps-for-please} ${py3-code-for-please}/please/please.py add "$words"
  else
    ${pkgs.lib.getExe py3-with-deps-for-please} ${py3-code-for-please}/please/please.py "$@"
  fi
''
