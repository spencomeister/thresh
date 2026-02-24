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

# Nginx stream proxy_pass does not support the "resolve" parameter.
RDPGW_UPSTREAM=$(printf '%s' "$RDPGW_UPSTREAM" | sed -E 's/[[:space:]]*resolve[[:space:]]*$//')

TEMPLATE="$ROOT_DIR/nginx/stream.d/rdgw.conf.template"
OUTPUT="$ROOT_DIR/nginx/stream.d/rdgw.conf"
LEGACY_HTTP_CONF="$ROOT_DIR/nginx/conf.d/rdgw.conf"

sed \
  -e "s/__DOMAIN__/${DOMAIN}/g" \
  -e "s/__RDPGW_UPSTREAM__/${RDPGW_UPSTREAM}/g" \
  "$TEMPLATE" > "$OUTPUT"

# Remove legacy http conf if it exists to avoid stream directive errors.
if [ -f "$LEGACY_HTTP_CONF" ]; then
  rm -f "$LEGACY_HTTP_CONF"
fi

