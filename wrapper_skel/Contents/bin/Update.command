#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
RESOURCES_DIR="${PROJECT_DIR}/Resources"

WINE_DIR="${RESOURCES_DIR}/usr/bin"
export WINEARCH=win32
export WINEPREFIX="${RESOURCES_DIR}/bottle"
export PATH="${WINE_DIR}:$PATH"

cd "${RESOURCES_DIR}"

echo "Reinstalling MTG Arena"
MTGA_VERSION="$(wget -qO- https://mtgarena.downloads.wizards.com/Live/Windows32/version | jq -r '.Versions | keys | .[0]')"
MTGA_VERSION_PATH="$(sed -nE 's/[0-9]+\.[0-9]+\.(.*)/\1/p' <<< ${MTGA_VERSION})"
wget -c https://mtgarena.downloads.wizards.com/Live/Windows32/versions/${MTGA_VERSION_PATH}/MTGAInstaller_${MTGA_VERSION}.msi
wine msiexec /x MTGAInstaller_${MTGA_VERSION}.msi /qn &> /dev/null
wine msiexec /i MTGAInstaller_${MTGA_VERSION}.msi /qn &> /dev/null

echo "Finished. Please close this window."

exit 0
