#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1

# Install Homebrew
if ! hash brew 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew
brew update

# Install Wine deps
brew install cabextract zenity winetricks
brew cask install xquartz

# Update winetricks
sudo winetricks --self-update

# Install wget, some people might not have it
brew install wget
