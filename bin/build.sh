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

# TODO - determine if official .net makes the game run better.

# echo "Installing Dot Net 4.6.2"
# winetricks -q dotnet462 &> /dev/null

echo "Installing xact"
winetricks xact &> /dev/null

echo "Installing MTG Arena"
MTGA_INSTALLER_URL="$(wget -qO- https://mtgarena.downloads.wizards.com/Live/Windows32/version | jq -r '.CurrentInstallerURL')"
MTGA_INSTALLER="$(sed -nE 's/.+\/(.+)/\1/p' <<< ${MTGA_INSTALLER_URL})"
wget -c ${MTGA_INSTALLER_URL}
wine msiexec /i ${MTGA_INSTALLER} /qn &> /dev/null

echo "MTG Arena installation complete"
open ${OUT_DIR}
