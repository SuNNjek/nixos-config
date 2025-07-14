#!/bin/sh
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

while getopts "h:" opt; do
    case "$opt" in
        h)
            HOST=$OPTARG
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

echo "Installing host config \"$HOST\"..."

# Format the drive
nix --experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest' -- \
    --mode destroy,format,mount --flake ".#$HOST"

# Install system
nixos-install --flake ".#$HOST" --root /mnt
