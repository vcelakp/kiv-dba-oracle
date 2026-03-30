#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
ENV_EXAMPLE_FILE="$ROOT_DIR/.env.example"

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
else
  # shellcheck disable=SC1090
  source "$ENV_EXAMPLE_FILE"
fi

CONTAINER_NAME="${CONTAINER_NAME:-oracle-xe-examples}"
HOST_PORT="${HOST_PORT:-1521}"
EXAMPLE_PDB="${EXAMPLE_PDB:-XEPDB1}"
EXAMPLE_USER="${EXAMPLE_USER:-ESQL}"
EXAMPLE_USER_PASSWORD="${EXAMPLE_USER_PASSWORD:-EsqlPwd123!}"

ensure_docker() {
  command -v docker >/dev/null 2>&1 || { echo "Docker is not installed." >&2; exit 1; }
  docker info >/dev/null 2>&1 || { echo "Docker is not running or is not available for the current user." >&2; exit 1; }
}

compose_cmd() {
  if docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  elif command -v docker-compose >/dev/null 2>&1; then
    docker-compose "$@"
  else
    echo "Missing Docker's compose or docker-compose." >&2
    exit 1
  fi
}

container_exists() {
  docker ps -a --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"
}

container_running() {
  docker ps --format '{{.Names}}' | grep -Fxq "$CONTAINER_NAME"
}

project_root() {
  printf '%s\n' "$ROOT_DIR"
}

print_header() {
  local choice="$1"
  local selected="$2"

  printf '\n'
  printf '%s\n' '======================================================================'
  printf '%s\n' ' Database Applications (KIV/DBA): Oracle Database PL/SQL Examples     '
  printf '%s\n' '----------------------------------------------------------------------'
  printf ' %-14s %s\n' "Menu choice:" "$choice"
  printf ' %-14s %s\n' "Example file:" "$selected"
  printf '%s\n' '======================================================================'
  printf '\n'
}

