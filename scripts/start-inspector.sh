#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT/windie/dev/windie-inspector"
if [ ! -d node_modules ]; then
  npm install --legacy-peer-deps
fi
exec npm start
