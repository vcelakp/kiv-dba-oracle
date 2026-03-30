#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

ensure_docker
cd "$(project_root)"

if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
    echo "Created .env as a copy of .env.example. You can change passwords and ports."
fi

compose_cmd up -d
"$SCRIPT_DIR/wait-until-ready.sh"

echo
echo "Oracle running ..."
echo "SQL*Plus inside Docker container: ./scripts/sql.sh"
echo "Interactive examples menu: ./scripts/menu.sh"
echo "Run a specific example directly: ./scripts/run-example.sh examples/01_hello-word-demo.sql"
