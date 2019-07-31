#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
TMP_DIR="${PROJECT_DIR}/tmp"
OUT_DIR="${PROJECT_DIR}/out"
SKEL_DIR="${PROJECT_DIR}/wrapper_skel"

# Create wrapper
if [ ! -d "${TMP_DIR}/bottle" ]; then
    echo "Bottle not found" 1>&2
    exit 1
fi

APP_NAME="MTGA.app"
APP_PATH="${OUT_DIR}/${APP_NAME}"

mkdir -p "${OUT_DIR}"

rm -rf "${APP_PATH}" &> /dev/null
cp -r "${SKEL_DIR}" "${APP_PATH}" || exit 1
chmod a+x "${APP_PATH}/Contents/MacOS/MTGALauncher"
cp -R "${TMP_DIR}/bottle" "${APP_PATH}/Contents/Resources/" || exit 1

echo "Wrapper created at '${APP_PATH}'."
