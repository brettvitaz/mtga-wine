#!/usr/bin/env bash
set -e

APP_NAME="MTGA.app"

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
SKEL_DIR="${PROJECT_DIR}/wrapper_skel"
OUT_DIR="${PROJECT_DIR}/out"
APP_DIR="${OUT_DIR}/${APP_NAME}"
RESOURCES_DIR="${APP_DIR}/Contents/Resources"

WINE_DIR="${RESOURCES_DIR}/usr/bin"
export WINEARCH=win32
export WINEPREFIX="${RESOURCES_DIR}/bottle"
export PATH="${WINE_DIR}:$PATH"

mkdir -p "${OUT_DIR}"

echo "Building application bundle"
rm -rf "${APP_DIR}" &> /dev/null
cp -r "${SKEL_DIR}" "${APP_DIR}" || exit 1
chmod a+x "${APP_DIR}/Contents/MacOS/MTGALauncher"
chmod a+x "${APP_DIR}/Contents/bin/Update.command"

cd "${RESOURCES_DIR}"

echo "Installing wine"
WINE_PACKAGE=portable-winehq-staging-3.21-osx.tar.gz
wget -c https://dl.winehq.org/wine-builds/macosx/pool/${WINE_PACKAGE}
tar -xzf ${WINE_PACKAGE}

# echo "Installing Dot Net 4.6.2"
# winetricks -q dotnet462 &> /dev/null

echo "Installing xact"
winetricks xact &> /dev/null

echo "Installing MTG Arena"
wget -c https://mtgarena.downloads.wizards.com/Live/Windows32/updates.txt
MTGA_VERSION="$(sed -nE 's/^ProductVersion\ =\ (.*)/\1/p' updates.txt | tr -d '\t\r\n')"
MTGA_VERSION_PATH="$(sed -nE 's/[0-9]+\.[0-9]+\.(.*)/\1/p' <<< ${MTGA_VERSION})"
wget -c https://mtgarena.downloads.wizards.com/Live/Windows32/versions/${MTGA_VERSION_PATH}/MTGAInstaller_${MTGA_VERSION}.msi
echo "wine msiexec /i MTGAInstaller_${MTGA_VERSION}.msi /qn &> /dev/null"
wine msiexec /i MTGAInstaller_${MTGA_VERSION}.msi /qn &> /dev/null

echo "MTG Arena installation complete"
open ${OUT_DIR}
