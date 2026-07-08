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

git -C "$ROOT/bifrost" log -1 --oneline

echo
echo "CUA"
if command -v cua-driver >/dev/null 2>&1; then
  cua-driver --version
else
  echo "cua-driver missing from PATH; CUA MCP tools will not be listed"
fi

echo
echo "DesktopCommanderMCP"
git -C "$ROOT/DesktopCommanderMCP" log -1 --oneline

echo
echo "blender-mcp"
git -C "$ROOT/blender-mcp" log -1 --oneline
