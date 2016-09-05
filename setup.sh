#!/bin/sh
# grab the installation script
curl https://nixos.org/nix/install > _install.sh
# explicitly set user
export USER=nix
bash _install.sh

. /home/nix/.nix-profile/etc/profile.d/nix.sh
