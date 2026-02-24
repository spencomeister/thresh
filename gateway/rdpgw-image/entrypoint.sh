#!/usr/bin/env sh
set -eu

RDPGW_BIN=""

if command -v rdpgw >/dev/null 2>&1; then
  RDPGW_BIN="$(command -v rdpgw)"
else
  RDPGW_BIN="$(find /usr/local -type f -name rdpgw 2>/dev/null | head -n 1 || true)"
fi

if [ -z "$RDPGW_BIN" ] || [ ! -x "$RDPGW_BIN" ]; then
  echo "rdpgw binary not found in PATH or /usr/local" >&2
  exit 1
fi

if [ -n "${RDPGW_ARGS:-}" ]; then
  exec "$RDPGW_BIN" $RDPGW_ARGS
fi

exec "$RDPGW_BIN"
