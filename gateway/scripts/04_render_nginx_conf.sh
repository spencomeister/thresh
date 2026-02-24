#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if [ ! -f "$ROOT_DIR/.env" ]; then
  echo "Missing .env. Run scripts/01_bootstrap_dirs.sh first."
  exit 1
fi

. "$ROOT_DIR/.env"

: "${DOMAIN:?DOMAIN is required}"
: "${RDPGW_UPSTREAM:?RDPGW_UPSTREAM is required}"

TEMPLATE="$ROOT_DIR/nginx/conf.d/rdgw.conf.template"
OUTPUT="$ROOT_DIR/nginx/conf.d/rdgw.conf"

sed \
  -e "s/__DOMAIN__/${DOMAIN}/g" \
  -e "s/__RDPGW_UPSTREAM__/${RDPGW_UPSTREAM}/g" \
  "$TEMPLATE" > "$OUTPUT"

