#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

mkdir -p "$ROOT_DIR/letsencrypt" \
  "$ROOT_DIR/logs/nginx" \
  "$ROOT_DIR/logs/rdpgw" \
  "$ROOT_DIR/rdpgw" \
  "$ROOT_DIR/tailscale"

if [ ! -f "$ROOT_DIR/.env" ]; then
  cp "$ROOT_DIR/.env.example" "$ROOT_DIR/.env"
  echo "Created .env from .env.example"
fi

if [ ! -f "$ROOT_DIR/certbot/cloudflare.ini" ]; then
  cp "$ROOT_DIR/certbot/cloudflare.ini.example" "$ROOT_DIR/certbot/cloudflare.ini"
  echo "Created certbot/cloudflare.ini from example"
fi

chmod 600 "$ROOT_DIR/certbot/cloudflare.ini"
