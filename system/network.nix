{ config, pkgs, ARGS, ... }:

{

  # config.programs.nm-applet.enable = true;
  # config.programs.nm-applet.indicator = true;

  config.networking.firewall.enable = true;

  # Home-local web-dev / mobile-web
  config.networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  # config.networking.firewall.extraCommands = ''
  # iptables -A INPUT -p tcp --dport 80 -j ACCEPT
  # '';

  config.networking.hostName = "nixos";
  config.networking.networkmanager.enable = true;
  config.users.users.mt.extraGroups = [
    "networkmanager"
    "sambashare"
  ];

  config.environment.systemPackages = [
    pkgs.android-file-transfer
    pkgs.pcmanfm
    pkgs.jmtpfs
    pkgs.pritunl-client
    pkgs.wireshark
    pkgs.tcpdump
    pkgs.traceroute
    pkgs.nmap
    pkgs.bind # that's gives also the "dig" utility
    pkgs.nettools # hostname nameif mii-tool ypdomainname slattach arp dnsdomainname plipconfig nisdomainname route domainname rarp ifconfig netstat
  ];

  # FTP is not nativelly supported by iOS or iPadOS-16, so using SMB.
  config.services.samba.enable = true;
  # config.services.samba.securityType = "share";
  config.services.samba.openFirewall = true;
  config.services.samba.enableWinbindd = false;
  config.services.samba.enableNmbd = false;
  config.services.samba.extraConfig = ''
[global]
guest account = ${ARGS.username}
map to guest = bad user
netbios name = ${ARGS.username}
server string = Samba %v on (%I)
workgroup = SIMPLE

#  Apple-fruit stuff
vfs objects = fruit streams_xattr
fruit:metadata = stream
fruit:model = MacSamba
fruit:posix_rename = yes
fruit:veto_appledouble = no
fruit:nfs_aces = no
fruit:wipe_intentionally_left_blank_rfork = yes
fruit:delete_empty_adfiles = yes

#  Networking configuration options
hosts allow = 192.168.1. localhost

[data]
path = /home/${ARGS.username}/SambaData
browseable = yes
guest ok = yes
writeable = yes

[kartinas-images]
path = /home/${ARGS.username}/KARTINAS/assets/images
browseable = yes
guest ok = yes
writeable = yes

[kartinas-fonts]
path = /home/${ARGS.username}/KARTINAS/assets/fonts
browseable = yes
guest ok = yes
writeable = yes
  '';
}
