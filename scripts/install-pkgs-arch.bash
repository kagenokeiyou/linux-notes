#!/bin/bash

packages=(
	sudo
	curl
	wget
	vim
	neovim
	helix
	lsd
	bat
	fd
	fzf
	bash-completion
	mesa-utils
)

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

if [[ $EUID -ne 0 ]]; then
	echo "${RED}Please run this script with sudo or as root!${NC}"
	exit 1
fi

echo "${BLUE}Updating package database...${NC}"
pacman -Sy

for pkg in "${packages[@]}"; do
	if pacman -Qi "${pkg}" &>/dev/null; then
		echo "${GREEN}${pkg} is already installed.${NC}"
	else
		echo "${BLUE}Installing ${pkg}...${NC}"
		pacman -S --noconfirm "${pkg}"
	fi
done

echo "${GREEN}All tasks completed!${NC}"
