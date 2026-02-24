#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

EXTRA_ARGS=""
if [ "${NO_CACHE:-0}" = "1" ]; then
	EXTRA_ARGS="--no-cache"
fi

docker compose -f "$ROOT_DIR/docker-compose.yml" build $EXTRA_ARGS rdpgw
