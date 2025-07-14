#!/bin/sh
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

while getopts "h:d:" opt; do
    case "$opt" in
        h)
            HOST=$OPTARG
            ;;
        d)
            DEVICE=$OPTARG
            ;;

        ?)
            echo "Invalid option: -${OPTARG}."
            exit 1
            ;;
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

echo "Installing host config \"$HOST\" on $DEVICE..."

# Format the drive
nix \
    --experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest' -- \
    --mode destroy,format,mount --flake ".#$HOST" --arg disk "$DEVICE"

# Install system
nixos-install --flake ".#$HOST" --root /mnt
