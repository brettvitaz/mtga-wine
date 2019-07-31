# Notes

## General

A new installer has been provided by Wizards that works well on Wine. Get the current version as of this writing: https://mtgarena.downloads.wizards.com/Live/Windows32/versions/1595.718832/MTGAInstaller_0.1.1595.718832.msi

## Install Homebrew

_Find information here: [Homebrew](https://brew.sh)_

Run installation script:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

If homebrew is already installed, make sure to update it (and optionally upgrade installed packages):

```bash
brew update
brew upgrade
```

## Install dependencies

Run from terminal:

```bash
brew install cabextract zenity winetricks
brew cask install xquartz
```

## Install Wine

Get and install wine 3.0.5 from here: https://dl.winehq.org/wine-builds/macosx/pool/winehq-stable-3.0.5.pkg

## Tweak winetricks

Ensure winetricks is the latest version:

```
sudo winetricks --self-update
```

## Create wine bottle

It is important to understand that wine creates a directory on your computer that contains the virtual "Windows C: drive" (known as a wine bottle). You can have multiple wine bottles on your computer and you can (should) install different applications in different bottles. Winetricks is somewhat of a package installer and config tool for wine.

This part is kind of specific to you and your configuration, but here is what I have done.

Create a directory to store your wine bottle:

```
cd ${HOME}
mkdir .bottles
cd .bottles
```

Create a wine bottle environment file that will store the path, known as a wine prefix. I named the file `~/.bottles/mtg-arena.bottle` and put in the following:

```
export WINEARCH=win32 
export WINEPREFIX="${HOME}/.bottles/mtg-arena"
```

Activate the new wine bottle, install .NET 4.6.2, xact (directx), and Arena:

```
source mtg-arena.bottle
winetricks -q dotnet462
winetricks xact
wine <PATH_TO_ARENA_INTSALLER>
```

## Run the game

Play it:

```
cd ${HOME}/.bottles
source mtg-arena.bottle
wine ${WINEPREFIX}/drive_c/Program\ Files/Wizards\ of\ the\ Coast/MTGA/MTGA.exe 
```
