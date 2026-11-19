#!/usr/bin/env bash
source "$(dirname "$0")/common.sh" "$@"
echo "WARNING: This deletes ALL resources in $RG"
read -r -p "Type the exact resource group name ($RG) to delete: " typed
[[ "$typed" == "$RG" ]] || { echo 'Cancelled'; exit 1; }
az group delete --name "$RG" --yes --no-wait
echo 'Deletion started. Check: az group exists -n '"$RG"
