#!/usr/bin/env bash
source "$(dirname "$0")/common.sh" "$@"
app=$(az webapp list -g "$RG" --query '[0].name' -o tsv)
[[ -n "$app" ]] || { echo "No web app in $RG. Set deployWeb=true in $PARAM, deploy again, then retry." >&2; exit 1; }
(cd "$ROOT/application" && zip -q -r /tmp/lab11-p07-app.zip .)
az webapp deploy -g "$RG" -n "$app" --src-path /tmp/lab11-p07-app.zip --type zip
az webapp show -g "$RG" -n "$app" --query defaultHostName -o tsv
