#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WINDIE_BIN="$ROOT/windie/target/release/windie"

cd "$ROOT/windie"

export WINDIE_DATA_DIR="${WINDIE_DATA_DIR:-$ROOT/.runtime/windie}"
export WINDIE_CONFIG_DIR="${WINDIE_CONFIG_DIR:-$ROOT/.runtime/config}"
if [ -f "$ROOT/windie/.env" ]; then
  export WINDIE_ENV_FILE="${WINDIE_ENV_FILE:-$ROOT/windie/.env}"
fi
if [ -x "$ROOT/bifrost/tmp/bifrost-http" ]; then
  export WINDIE_BIFROST_BIN="${WINDIE_BIFROST_BIN:-$ROOT/bifrost/tmp/bifrost-http}"
fi

if [ -x "$WINDIE_BIN" ]; then
  exec "$WINDIE_BIN" gateway start
fi

exec cargo run -- gateway start
