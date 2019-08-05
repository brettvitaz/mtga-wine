#!/usr/bin/env bash
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" || exit 1

${PROJECT_DIR}/bin/prerequisites.sh
${PROJECT_DIR}/bin/build.sh
