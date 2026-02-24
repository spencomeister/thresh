#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if [ ! -f "$ROOT_DIR/.env" ]; then
  echo "Missing .env. Run scripts/01_bootstrap_dirs.sh first."
  exit 1
fi

. "$ROOT_DIR/.env"

: "${DOMAIN:?DOMAIN is required}"
: "${CF_API_TOKEN:?CF_API_TOKEN is required}"

if [ ! -f "$ROOT_DIR/certbot/cloudflare.ini" ]; then
  echo "Missing certbot/cloudflare.ini. Run scripts/01_bootstrap_dirs.sh first."
  exit 1
fi

chmod 600 "$ROOT_DIR/certbot/cloudflare.ini"

docker compose -f "$ROOT_DIR/docker-compose.yml" run --rm certbot \
  renew \
  --non-interactive \
  --dns-cloudflare \
  --dns-cloudflare-credentials /cloudflare.ini \
  --dns-cloudflare-propagation-seconds 60

"$ROOT_DIR/scripts/04_render_nginx_conf.sh"
