#!/usr/bin/env bash

# TODO - Make this a wrapper that downloads an updated script

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
RESOURCES_DIR="${PROJECT_DIR}/Resources"

WINE_DIR="${RESOURCES_DIR}/usr/bin"
export WINEARCH=win32
export WINEPREFIX="${RESOURCES_DIR}/bottle"
export PATH="${WINE_DIR}:$PATH"

cd "${RESOURCES_DIR}"

# TODO - use the patch installer instead of reinstalling

echo "Reinstalling MTG Arena"
MTGA_INSTALLER_URL="$(wget -qO- https://mtgarena.downloads.wizards.com/Live/Windows32/version | jq -r '.CurrentInstallerURL')"
MTGA_INSTALLER="$(sed -nE 's/.+\/(.+)/\1/p' <<< ${MTGA_INSTALLER_URL})"
wget -c ${MTGA_INSTALLER_URL}
echo "msiexec /i ${MTGA_INSTALLER} /qn &> /dev/null"
wine msiexec /x ${MTGA_INSTALLER} /qn &> /dev/null
wine msiexec /i ${MTGA_INSTALLER} /qn &> /dev/null

echo "Finished. Please close this window."

exit 0
