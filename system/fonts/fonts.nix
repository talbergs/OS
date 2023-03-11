{ config, pkgs, ... }:

let
  comic-code = pkgs.stdenv.mkDerivation {
    # buildPhase = ''
    # TODO: keep the in files encripted form so could be commited to github
    # '';
    name = "secret-comic-code-font";
    src = ./.;
    installPhase = ''
      install -m444 -Dt $out/share/fonts/comic-code *.otf
    '';
  };

  comic-code-patched = pkgs.stdenv.mkDerivation {
    name = "secret-comic-code-font-patched";
    nativeBuildInputs = [pkgs.nerd-font-patcher comic-code];
    phases = ["installPhase"];

    preInstall = ''
      mkdir -p $out/share/fonts/truetype && cd "$_"
    '';

    installPhase = ''
      runHook preInstall
      find ${comic-code}/share/fonts/comic-code \
        -name \*.otf \
        -exec ${pkgs.nerd-font-patcher}/bin/nerd-font-patcher --complete --quiet --no-progressbars {} \; \
        -exec ${pkgs.nerd-font-patcher}/bin/nerd-font-patcher --complete --use-single-width-glyphs --adjust-line-height --quiet --no-progressbars {} \;
    '';
  };

  tabler-icons = pkgs.stdenv.mkDerivation rec {
    name = "tabler-icons-font";
    src = pkgs.fetchFromGitHub {
		owner = "tabler";
		repo = "tabler-icons";
		rev = "v2.2.0";
		sha256 = "sha256-ail73JnrZ4wtTrXFXtgKCpL4aHvPq/quRyH+j+oRKfY=";
	};
    installPhase = let
      fontFile = "${src}/packages/icons-webfont/fonts/tabler-icons.ttf";
    in ''
      install -m444 -Dt $out/share/fonts/tabler ${fontFile}
    '';
  };

in

{

  config.fonts.fonts = [ 
     comic-code
     comic-code-patched
     tabler-icons
  ];

}
