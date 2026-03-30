#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

ensure_docker

if ! container_running; then
  echo "Docker container $CONTAINER_NAME is not running." >&2
  exit 1
fi

printf 'Wait for Oracle in Docker container %s ...\n' "$CONTAINER_NAME"
for _ in $(seq 1 180); do
  health_status="$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "$CONTAINER_NAME" 2>/dev/null || true)"
  if [[ "$health_status" == "healthy" ]]; then
    echo "Database is ready (healthcheck=healthy)."
    exit 0
  fi

  if docker exec "$CONTAINER_NAME" bash -lc "echo 'exit' | sqlplus -L / as sysdba >/dev/null 2>&1"; then
    echo "Database connection using SQL*Plus is ready."
    exit 0
  fi

  sleep 5
done

echo "Database start taken too long. Canceled." >&2
docker logs --tail 200 "$CONTAINER_NAME" >&2 || true
exit 1
