#!/usr/bin/env bash
set -e

# Install a pinned Flutter SDK and build the web bundle for Vercel.
V=3.24.3
FH="$PWD/.flutter"

# Try to install deps when a package manager exists; otherwise continue.
if command -v apt-get >/dev/null 2>&1; then
  apt-get update
  apt-get install -y xz-utils unzip libglu1-mesa
elif command -v apk >/dev/null 2>&1; then
  apk add --no-cache xz unzip mesa-gl
fi

rm -rf "$FH"
mkdir -p "$FH"
curl -Ls "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${V}-stable.tar.xz" \
  | tar -xJ --strip-components=1 -C "$FH"

export PATH="$FH/bin:$PATH"

flutter config --no-analytics
flutter pub get
flutter build web --release
