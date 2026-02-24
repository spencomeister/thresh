#!/usr/bin/env sh
set -eu

RDPGW_BIN="/usr/local/sbin/rdpgw"

if [ ! -x "$RDPGW_BIN" ]; then
  echo "rdpgw binary not found at $RDPGW_BIN" >&2
  exit 1
fi

if [ -n "${RDPGW_ARGS:-}" ]; then
  exec "$RDPGW_BIN" $RDPGW_ARGS
fi

exec "$RDPGW_BIN"
