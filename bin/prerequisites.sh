#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1

# Install Homebrew
if ! hash brew 2>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Update Homebrew"
brew update

echo "Install Wine deps"
brew install cabextract jq wget winetricks zenity
brew cask install xquartz

echo "Update winetricks"
sudo winetricks --self-update
