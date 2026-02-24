#!/usr/bin/env sh
set -eu

RDPGW_BIN=""
RDPGW_CANDIDATES="rdpgw freerdp-proxy"

for candidate in $RDPGW_CANDIDATES; do
  if command -v "$candidate" >/dev/null 2>&1; then
    RDPGW_BIN="$(command -v "$candidate")"
    break
  fi
done

if [ -z "$RDPGW_BIN" ]; then
  for candidate in $RDPGW_CANDIDATES; do
    RDPGW_BIN="$(find /usr/local -type f -name "$candidate" 2>/dev/null | head -n 1 || true)"
    if [ -n "$RDPGW_BIN" ]; then
      break
    fi
  done
fi

if [ -z "$RDPGW_BIN" ] || [ ! -x "$RDPGW_BIN" ]; then
  echo "Gateway binary not found (tried: $RDPGW_CANDIDATES)" >&2
  exit 1
fi

if [ -n "${RDPGW_ARGS:-}" ]; then
  exec "$RDPGW_BIN" $RDPGW_ARGS
fi

exec "$RDPGW_BIN"
