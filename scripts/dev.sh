#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Windie workspace dev commands"
echo
echo "Run these in separate terminals:"
echo "$ROOT/scripts/start-gateway.sh"
echo "$ROOT/scripts/start-api.sh"
echo "$ROOT/scripts/start-inspector.sh"
