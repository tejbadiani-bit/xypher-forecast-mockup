#!/bin/bash
# Refresh the real Salesforce numbers, rebuild, encrypt behind the password gate and push to GitHub Pages.
# Prompts for the password so it never lands in a file, the repo or shell history.
# Only the encrypted gate (index.html) is committed; src/ and data/ are gitignored.
set -euo pipefail
cd "$(dirname "$0")"
read -rsp "Site password: " PW; echo
[ -n "$PW" ] || { echo "No password entered - nothing published."; exit 1; }
python3 data/extract.py          # read-only pulls from Xypher_Prod + Xypher_Sandbox_FC
python3 build.py
printf %s "$PW" | node build/encrypt.js -
unset PW
rm -f data/index.plain.html index.html.bak
git add index.html assets/img/dxr-cyber-logo.png build/encrypt.js build.py publish.sh .gitignore README.md
git commit -m "Publish forecast site (real data as at $(date +%Y-%m-%d))" || echo "(no changes to commit)"
git push origin main
echo "Live in about a minute: https://tejbadiani-bit.github.io/xypher-forecast-mockup/"
