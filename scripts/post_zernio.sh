#!/usr/bin/env bash
# Tạo bài trên Zernio từ content/<slug>/.
# Mặc định chỉ tạo NHÁP. Chỉ đăng/lên lịch khi có file duyệt khớp nội dung.
#
# Dùng:  scripts/post_zernio.sh <slug>                  # tạo nháp
#        scripts/post_zernio.sh <slug> --schedule <ISO>  # lên lịch (cần duyệt)
#        scripts/post_zernio.sh <slug> --publish         # đăng ngay (cần duyệt)
set -euo pipefail
cd "$(dirname "$0")/.."

slug="${1:?thiếu <slug>}"; shift || true
mode=draft; when=""
while [ $# -gt 0 ]; do
  case "$1" in
    --publish) mode=publish ;;
    --schedule) mode=schedule; when="${2:?thiếu thời gian ISO}"; shift ;;
    *) echo "tham số lạ: $1" >&2; exit 2 ;;
  esac; shift
done

dir="content/$slug"
[ -f "$dir/post.md" ] && [ -f "$dir/platforms.json" ] || { echo "thiếu $dir/post.md hoặc platforms.json" >&2; exit 1; }
: "${ZERNIO_API_KEY:?chưa đặt ZERNIO_API_KEY trong environment}"

hash=$(cat "$dir/post.md" "$dir/platforms.json" | sha256sum | cut -d' ' -f1)

if [ "$mode" != draft ]; then
  ok="approvals/$slug.approved"
  if [ ! -f "$ok" ] || [ "$(cat "$ok")" != "$hash" ]; then
    echo "TỪ CHỐI: chưa có duyệt hợp lệ cho '$slug' (hoặc nội dung đã đổi sau khi duyệt)." >&2
    exit 3
  fi
fi

body=$(DIR="$dir" MODE="$mode" WHEN="$when" python3 -I - <<'PY'
import json, os
d = os.environ["DIR"]
b = {"content": open(f"{d}/post.md", encoding="utf-8").read().strip(),
     "platforms": json.load(open(f"{d}/platforms.json"))}
if os.environ["MODE"] == "publish": b["publishNow"] = True
if os.environ["MODE"] == "schedule": b["scheduledFor"] = os.environ["WHEN"]
print(json.dumps(b, ensure_ascii=False))
PY
)

echo "Chế độ: $mode"
curl -sS -X POST https://zernio.com/api/v1/posts \
  -H "Authorization: Bearer $ZERNIO_API_KEY" \
  -H 'Content-Type: application/json' \
  -d "$body"
echo
