#!/usr/bin/env sh

CONNECTION_NAME=SUSE-Engineering

if [[ -n $(nmcli connection show $CONNECTION_NAME | grep "VPN connected") ]]; then
  nmcli connection down $CONNECTION_NAME;
else
  nmcli connection up $CONNECTION_NAME;
fi