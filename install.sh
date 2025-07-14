#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

while getopts "hd" opt; do
    case "$opt" in
        h)
            HOST=$OPTARG
        d)
            DEVICE=$OPTARG
    esac
done

if [[ -z $HOST ]]; then
   echo "You must specify a host to install" 
   exit 1
fi

if [[ -z $DEVICE ]]; then
   echo "You must specify a device to install to" 
   exit 1
fi


nix run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake ".#$HOST" --disk main $DEVICE
