#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIFROST_BASE_COMMIT="a52d1804c0d1bc5395b403fb7b74998a4fbf7237"

echo "Initializing submodules"
git -C "$ROOT" submodule update --init --recursive

if [ -d "$ROOT/patches/bifrost" ]; then
  if git -C "$ROOT/bifrost" log --oneline -5 | grep -q "Expose chat-capable model filtering"; then
    echo "Bifrost patches already applied"
  else
    if [ -n "$(git -C "$ROOT/bifrost" status --porcelain)" ]; then
      echo "Bifrost worktree has local changes; refusing to apply patches" >&2
      exit 1
    fi

    echo "Applying Windie Bifrost patches"
    git -C "$ROOT/bifrost" checkout -B windie-local "$BIFROST_BASE_COMMIT"
    git -C "$ROOT/bifrost" am --3way "$ROOT"/patches/bifrost/*.patch
  fi
fi

echo "Building Windie release binary"
cargo build --release --manifest-path "$ROOT/windie/Cargo.toml"

echo "Bootstrap complete"
echo "Next: copy .env.example to windie/.env and run scripts/status.sh"
