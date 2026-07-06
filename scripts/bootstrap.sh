#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Initializing submodules"
git -C "$ROOT" submodule update --init --recursive

echo "Building Windie release binary"
cargo build --release --manifest-path "$ROOT/windie/Cargo.toml"

echo "Bootstrap complete"
echo "Next: copy .env.example to windie/.env and run scripts/status.sh"
