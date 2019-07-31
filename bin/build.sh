#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
BIN_DIR="${PROJECT_DIR}/bin"
TMP_DIR="${PROJECT_DIR}/tmp"
OUT_DIR="${PROJECT_DIR}/out"
SKEL_DIR="${PROJECT_DIR}/wrapper_skel"

WINE_DIR="/Applications/Wine Stable.app/Contents/Resources/wine/bin"
export PATH="${WINE_DIR}:$PATH"

export WINEARCH=win32 
export WINEPREFIX="${TMP_DIR}/bottle"

mkdir -p "${TMP_DIR}"
cd "${TMP_DIR}"

wget -c https://mtgarena.downloads.wizards.com/Live/Windows32/versions/1595.718832/MTGAInstaller_0.1.1595.718832.msi

echo "Installing Dot Net 4.6.2"
winetricks -q dotnet462 &> /dev/null

echo "Installing xact"
winetricks xact &> /dev/null

echo "Installing MTGA"
wine msiexec /i MTGAInstaller_0.1.1595.718832.msi /qn &> /dev/null
