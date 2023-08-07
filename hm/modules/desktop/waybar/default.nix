# https://github.com/Alexays/Waybar/wiki/Configuration
{ sound-bin }:
{
  programs.waybar.enable = true;
  programs.waybar.style = builtins.readFile ./style.css;
  programs.waybar.settings.mainBar = builtins.fromJSON (builtins.readFile ./config.json);
}
