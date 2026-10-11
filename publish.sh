#!/bin/bash
# Copies the current Plebtown playable into this repo and pushes it live.
# Usage: ./publish.sh [path to built preview.html]
set -euo pipefail
SRC="${1:-$HOME/Desktop/Plebtown/prototype/pt042-candidate-v2/preview.html}"
cd "$(dirname "$0")"
cp "$SRC" index.html
BUILD=$(grep -oE 'Build [0-9a-f]{16}' index.html | head -1 || true)
git add index.html
if git diff --cached --quiet; then echo "No change since the last publish."; exit 0; fi
git commit -m "Publish playable${BUILD:+ ($BUILD)}"
git push
echo "Live in about a minute at https://adilallo.github.io/plebtown-play/"
