#!/bin/sh
cd /home/jake/NokNok/
sudo nixos-rebuild switch --flake .#nixos
cd ..
