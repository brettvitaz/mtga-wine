#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
TMP_DIR="${PROJECT_DIR}/tmp"

cd "${TMP_DIR}"

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

# Install Wine
wget -c https://dl.winehq.org/wine-builds/macosx/pool/winehq-stable-3.0.5.pkg
sudo installer -pkg winehq-stable-3.0.5.pkg -target /
