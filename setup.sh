#!/bin/bash

sudo apt install -y fzf fish pipx

# install jrnl
pipx install jrnl
pipx ensurepath

stow asdf
stow fish
stow nvm
stow jrnl
