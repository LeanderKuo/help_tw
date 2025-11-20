#!/usr/bin/env bash
set -e

# Install a pinned Flutter SDK and build the web bundle for Vercel.
V=3.38.1
FH="$PWD/.flutter"

# Try to install deps when a package manager exists; otherwise continue.
if command -v apt-get >/dev/null 2>&1; then
  apt-get update
  apt-get install -y xz-utils unzip libglu1-mesa
elif command -v apk >/dev/null 2>&1; then
  apk add --no-cache xz unzip mesa-gl
elif command -v yum >/dev/null 2>&1; then
  yum install -y xz unzip mesa-libGL
elif command -v dnf >/dev/null 2>&1; then
  dnf install -y xz unzip mesa-libGL
fi

rm -rf "$FH"
mkdir -p "$FH"
curl -Ls "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${V}-stable.tar.xz" \
  | tar -xJ --strip-components=1 -C "$FH"

export PATH="$FH/bin:$PATH"

# Avoid git safety prompts inside the Flutter SDK.
git config --global --add safe.directory "$FH" || true

flutter config --no-analytics
flutter pub get

# Ensure Supabase env vars exist before building.
if [ -z "${SUPABASE_URL:-}" ] || [ -z "${SUPABASE_ANON_KEY:-}" ]; then
  echo "Missing SUPABASE_URL or SUPABASE_ANON_KEY environment variables for build." >&2
  exit 1
fi

flutter build web --release \
  --dart-define=SUPABASE_URL="$SUPABASE_URL" \
  --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
