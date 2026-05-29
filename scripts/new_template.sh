#!/usr/bin/env bash
set -euo pipefail
if [ "$#" -ne 3 ]; then
  echo "Usage: scripts/new_template.sh <platform> <type> <slug>"
  exit 1
fi
platform="$1"
type="$2"
slug="$3"
dest="templates/${platform}/${type}/${platform}-${type}-${slug}"
cp -R scaffolds/template-skeleton "$dest"
echo "Created $dest"
