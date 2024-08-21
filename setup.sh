#!/bin/bash

sudo apt install -y fzf fish pipx xclip

# install jrnl
pipx install jrnl
pipx ensurepath

# install rbw
curl -s https://git.tozt.net/rbw/releases/deb/rbw_1.12.1_amd64.deb -o /tmp/rbw.deb
sudo apt install -y /tmp/rbw.deb

stow asdf
stow fish
stow nvm
stow jrnl
