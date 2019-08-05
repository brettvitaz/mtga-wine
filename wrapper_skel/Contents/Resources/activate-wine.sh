#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.." || exit 1
RESOURCES_DIR="${PROJECT_DIR}/Resources"

WINE_DIR="${RESOURCES_DIR}/usr/bin"
export WINEARCH=win32
export WINEPREFIX="${RESOURCES_DIR}/bottle"
export PATH="${WINE_DIR}:$PATH"
