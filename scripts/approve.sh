#!/usr/bin/env bash
# Ghi nhận duyệt cho content/<slug>/. Chỉ chạy SAU KHI người dùng nhắn "duyệt".
# File duyệt chứa hash nội dung: sửa bài sau đó thì duyệt mất hiệu lực.
set -euo pipefail
cd "$(dirname "$0")/.."
slug="${1:?thiếu <slug>}"; dir="content/$slug"
[ -f "$dir/post.md" ] && [ -f "$dir/platforms.json" ] || { echo "thiếu file bài" >&2; exit 1; }
mkdir -p approvals
cat "$dir/post.md" "$dir/platforms.json" | sha256sum | cut -d' ' -f1 > "approvals/$slug.approved"
echo "Đã ghi duyệt cho $slug"
