{ pkgs, ... }:

{

  environment.systemPackages = [ pkgs.chromium ];
  programs.chromium.enable = true;
  programs.chromium.extensions = [
    # "gfbliohnnapiefjpjlpjnehglfpaknnc" # surfingkeys
    "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
    "egpjdkipkomnmjhjmdamaniclmdlobbo" # firenvim < TODO?
  ];

}

