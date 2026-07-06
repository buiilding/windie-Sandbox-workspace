#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WINDIE_BIN="$ROOT/windie/target/release/windie"

cd "$ROOT/windie"

if [ -x "$WINDIE_BIN" ]; then
  exec "$WINDIE_BIN" api
fi

exec cargo run -- api
