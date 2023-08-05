{
  programs.mpv.enable = true;
  programs.mpv.bindings = {
    "s" = "cycle sub";
    "S" = "cycle sub down";
  };
  programs.mpv.config = {
    keep-open = "yes";
    sub-auto = "all";
    sub-file-paths-append = ["Subs" "subs"];
    ytdl-format = "bestvideo[height<=720]+bestaudio/best[height<=720]";
    ytdl-raw-options = ''sub-lang="en",write-sub=,write-auto-sub='';
  };
}
