#!/usr/bin/env bash
set -euo pipefail

find_project_root() {
  local dir="$1"

  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/docker-compose.yml" || -f "$dir/compose.yml" || -f "$dir/compose.yaml" ]]; then
      printf '%s\n' "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
  done

  return 1
}

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${SCRIPT_PATH}")" && pwd)"

if ! PROJECT_ROOT="$(find_project_root "${SCRIPT_DIR}")"; then
  echo "ERROR: Could not find docker-compose.yml / compose.yml / compose.yaml in this directory or any parent directory." >&2
  echo "Place this script inside the project tree, ideally in <project>/scripts/." >&2
  exit 1
fi

cd "${PROJECT_ROOT}"

if [[ -f .env ]]; then
  set -a
  # shellcheck disable=SC1091
  source .env
  set +a
fi

CONTAINER_NAME="${CONTAINER_NAME:-kiv-dba-oracle}"
EXAMPLE_PDB="${EXAMPLE_PDB:-XEPDB1}"
EXAMPLE_USER="${EXAMPLE_USER:-STUDENT}"

echo "Project root: ${PROJECT_ROOT}"
echo "Container:    ${CONTAINER_NAME}"
echo "PDB:          ${EXAMPLE_PDB}"
echo "User:         ${EXAMPLE_USER}"
echo

echo "Stopping and removing existing stack..."
docker compose down -v --remove-orphans || true

echo "Removing leftover containers with known names..."
docker rm -f "${CONTAINER_NAME}" oracle-xe-examples 2>/dev/null || true

echo "Starting Oracle from scratch..."
docker compose up -d --force-recreate

echo "Waiting for Oracle healthcheck..."
until [[ "$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}no-healthcheck{{end}}' "${CONTAINER_NAME}" 2>/dev/null || true)" == "healthy" ]]; do
  sleep 5
  echo "  still waiting..."
done

echo "Database is healthy."
echo

echo "Verifying that ${EXAMPLE_USER} exists in ${EXAMPLE_PDB}..."
docker exec -i "${CONTAINER_NAME}" sqlplus -s / as sysdba <<SQL
WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER SESSION SET CONTAINER=${EXAMPLE_PDB};
SET HEADING ON
SET FEEDBACK ON
SET PAGESIZE 100
COL USERNAME FORMAT A30
COL ACCOUNT_STATUS FORMAT A20
SELECT username, account_status
FROM dba_users
WHERE username = UPPER('${EXAMPLE_USER}');
EXIT
SQL

echo
echo "Done."
echo "You can now run:"
echo "  ./scripts/menu.sh"
echo "  ./scripts/sql.sh"
