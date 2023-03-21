{ config, pkgs, ... }:

{

  # config.programs.nm-applet.enable = true;
  # config.programs.nm-applet.indicator = true;

  config.networking.firewall.enable = true;

  # Home-local web-dev / mobile-web
  config.networking.firewall.allowedTCPPorts = [ 80 443 ];

  # config.networking.firewall.extraCommands = ''
  # iptables -A INPUT -p tcp --dport 80 -j ACCEPT
  # '';

  config.networking.hostName = "nixos";
  config.networking.networkmanager.enable = true;
  config.users.users.mt.extraGroups = [ "networkmanager" ];

  config.environment.systemPackages = [
    pkgs.pritunl-client
    pkgs.wireshark
    pkgs.traceroute
    pkgs.nmap
    pkgs.bind # that's gives also the "dig" utility
    pkgs.nettools # hostname nameif mii-tool ypdomainname slattach arp dnsdomainname plipconfig nisdomainname route domainname rarp ifconfig netstat
  ];

}
