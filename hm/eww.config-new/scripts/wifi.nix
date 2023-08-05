{pkgs}: pkgs.writeShellScriptBin "nm-wifi" ''
#!/usr/bin/env bash
echo "333WIFI0000"
# ${pkgs.networkmanager}/bin/nmcli
''
