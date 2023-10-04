#!/bin/bash
cat /etc/hosts.new >> /etc/hosts
echo $VPNPASS | openconnect --user="$VPNUSER" -b --no-proxy --authgroup="Claro" --quiet --dump-http-traffic --disable-ipv6 --servercert="sha256:52fb34c867bffaf39c496bb8fc3557949f9e62e344a8d5db9bcdccfdd386340e" --os=win 200.192.85.213 

exec "$@"