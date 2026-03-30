#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

ensure_docker

if ! container_running; then
  "$SCRIPT_DIR/start.sh"
fi
"$SCRIPT_DIR/wait-until-ready.sh"

docker exec -it "$CONTAINER_NAME" bash -lc "sqlplus ${EXAMPLE_USER}/${EXAMPLE_USER_PASSWORD}@${EXAMPLE_PDB}"
