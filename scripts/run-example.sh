#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

usage() {
  echo "Usage: $0 <example.sql>"
  echo "Example: $0 examples/00_hello-world-demo.sql"
}

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 1
fi

HOST_FILE="$1"
ROOT_DIR="$(project_root)"

if [[ ! -f "$HOST_FILE" ]]; then
  if [[ -f "$ROOT_DIR/$HOST_FILE" ]]; then
    HOST_FILE="$ROOT_DIR/$HOST_FILE"
  else
    echo "Missing file: $1" >&2
    exit 1
  fi
fi

ABS_FILE="$(cd "$(dirname "$HOST_FILE")" && pwd)/$(basename "$HOST_FILE")"
case "$ABS_FILE" in
  "$ROOT_DIR"/*) ;;
  *)
    echo "Script must be inside the project: $ROOT_DIR" >&2
    exit 1
    ;;
esac

REL_PATH="${ABS_FILE#$ROOT_DIR/}"
CONTAINER_FILE="/workspace/$REL_PATH"

if ! container_running; then
  "$SCRIPT_DIR/start.sh"
fi
"$SCRIPT_DIR/wait-until-ready.sh"

echo "Running $REL_PATH"
docker exec -i "$CONTAINER_NAME" bash -lc "sqlplus -L '${EXAMPLE_USER}/${EXAMPLE_USER_PASSWORD}@${EXAMPLE_PDB}' '@${CONTAINER_FILE}'"
