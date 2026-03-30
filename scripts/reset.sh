#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

ensure_docker
cd "$(project_root)"
compose_cmd down -v

echo "Both, Docker container and data volume were removed. Next start will do clean initialisation." 
