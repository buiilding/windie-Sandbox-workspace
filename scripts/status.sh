#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Submodules"
git -C "$ROOT" submodule status

echo
echo "Windie"
if [ -x "$ROOT/windie/target/release/windie" ]; then
  "$ROOT/windie/target/release/windie" --version
else
  echo "release binary missing: run ./scripts/bootstrap.sh"
fi

echo
echo "Bifrost"
if [ -x "$ROOT/bifrost/tmp/bifrost-http" ]; then
  echo "local gateway binary present: bifrost/tmp/bifrost-http"
else
  echo "local gateway binary missing: build Bifrost or let Windie use its public fallback"
fi

if git -C "$ROOT/bifrost" log --oneline -5 | grep -q "Expose chat-capable model filtering"; then
  echo "Windie Bifrost patches applied"
else
  echo "Windie Bifrost patches not applied: run ./scripts/bootstrap.sh"
fi

echo
echo "CUA"
if command -v cua-driver >/dev/null 2>&1; then
  cua-driver --version
else
  echo "cua-driver missing from PATH; CUA MCP tools will not be listed"
fi
