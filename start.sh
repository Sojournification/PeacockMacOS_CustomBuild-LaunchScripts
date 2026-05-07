#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCHER_BIN="$SCRIPT_DIR/patcher-darwin/build/PeacockPatcher"

if [ ! -f "$PATCHER_BIN" ]; then
  echo "Error: PeacockPatcher binary not found at $PATCHER_BIN"
  echo "Run ./build.sh first."
  exit 1
fi

cleanup() {
  echo ""
  echo "Shutting down Peacock server..."
  kill "$SERVER_PID" 2>/dev/null || true
  wait "$SERVER_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

# Kill any leftover process on port 80
EXISTING=$(sudo lsof -ti :80 2>/dev/null || true)
if [ -n "$EXISTING" ]; then
  echo "==> Clearing stale process on port 80 (PID $EXISTING)..."
  sudo kill "$EXISTING" 2>/dev/null || true
  sleep 1
fi

echo "==> Starting Peacock server on port 80..."
cd "$SCRIPT_DIR"
sudo env PATH="$PATH" /opt/homebrew/bin/yarn start &
SERVER_PID=$!

echo "Server PID: $SERVER_PID"
echo ""
echo "Waiting 5 seconds for server to come up..."
sleep 5

echo ""
echo "==> Launching patcher..."
echo "    Make sure Hitman WOA is running and sitting at the main menu."
echo ""
sudo "$PATCHER_BIN" --disable-dynamic-resources --domain 127.0.0.1:80

echo ""
echo "Patcher exited. Press Ctrl+C to stop the server."
wait "$SERVER_PID"
