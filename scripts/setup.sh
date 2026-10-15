#!/usr/bin/env bash
# Setup script cho cloud environment (dán vào Environment -> Edit -> Setup script).
# Chỉ cài công cụ. KHÔNG đặt key hay token trong file này.
set -uo pipefail

echo "== Zernio CLI =="
npm install -g --silent @zernio/cli || echo "WARN: không cài được @zernio/cli"

echo "== Reelcrew CLI =="
if ! command -v reelcrew >/dev/null 2>&1; then
  curl -fsSL https://reelcrew.io/install.sh | REELCREW_INSTALL_PATH=yes REELCREW_NO_INPUT=1 sh \
    || echo "WARN: không cài được Reelcrew (kiểm tra Allowed domains: reelcrew.io)"
fi
export PATH="$HOME/.local/bin:$HOME/.reelcrew/bin:$PATH"

echo "== Kiểm tra nhanh =="
for c in node python3 ffmpeg curl npm; do
  command -v "$c" >/dev/null 2>&1 && echo "ok   $c" || echo "MISS $c"
done
command -v zernio >/dev/null 2>&1 && echo "ok   zernio" || echo "MISS zernio"
command -v reelcrew >/dev/null 2>&1 && echo "ok   reelcrew" || echo "MISS reelcrew"

# AgentKit (ak) là tuỳ chọn, chỉ cần khi dùng nó để phát triển repo:
#   curl -fsSL https://agentkit.best/install.sh | sh
#   ak login --api-key "$AK_API_KEY" --no-interactive
#   ak kit init marketing --target claude-code --global
exit 0
