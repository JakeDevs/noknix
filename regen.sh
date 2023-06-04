#!/bin/sh
cd /home/jake/noknix/
sudo nixos-rebuild switch --flake .#nixos
cd ..
