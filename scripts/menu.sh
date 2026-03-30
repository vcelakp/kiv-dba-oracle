#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

ROOT_DIR="$(project_root)"

list_candidates() {
  {
    find "$ROOT_DIR/examples" -maxdepth 1 -type f -name '*.sql' 2>/dev/null
    find "$ROOT_DIR" -maxdepth 1 -type f -name '*.sql' 2>/dev/null
  } | awk '!seen[$0]++' | sort
}

mapfile -t FILES < <(list_candidates)

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No .sql examples were found in $ROOT_DIR nor $ROOT_DIR/examples." >&2
  exit 1
fi

echo "Available examples:"
for i in "${!FILES[@]}"; do
  rel="${FILES[$i]#$ROOT_DIR/}"
  printf '  %2d) %s\n' "$((i + 1))" "$rel"
done

echo
read -r -p "Choose number of file you want to run: " choice

if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#FILES[@]} )); then
  echo "Wrong choice." >&2
  exit 1
fi

selected="${FILES[$((choice - 1))]}"
"$SCRIPT_DIR/run-example.sh" "$selected"
