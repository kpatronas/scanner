#!/bin/bash
rm -rf /tmp/nmap_*
network=$1
network_params='-n -sn'
host_scan_params='-p- -sV -sC'
nmap $network $network_params -oG - | grep 'Status: Up' | cut -d " " -f2 | xargs -P20 -I {} bash -c 'nmap $host_scan_params {} > /tmp/nmap_{}'
find /tmp/ -name 'nmap_*' -type f 2>/dev/null | xargs -I {} bash -c 'echo " ";cat {}|grep -i "scan report for\|open"'
