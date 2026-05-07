#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCHER_DIR="$SCRIPT_DIR/patcher-darwin"
BUILD_DIR="$PATCHER_DIR/build"

echo "==> Installing Node dependencies..."
cd "$SCRIPT_DIR"
corepack enable
yarn install

echo ""
echo "==> Building patcher..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .

echo ""
echo "Done. Patcher binary: $BUILD_DIR/PeacockPatcher"
