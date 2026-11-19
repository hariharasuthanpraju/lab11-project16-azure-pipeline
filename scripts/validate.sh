#!/usr/bin/env bash
source "$(dirname "$0")/common.sh" "$@"
az account show --query '{name:name,id:id}' -o table
az bicep version
az bicep build --file "$ROOT/infrastructure/main.bicep" --outfile /tmp/lab11-p07-main.json
az bicep build-params --file "$PARAM" --outfile "/tmp/lab11-p07-${ENV}.parameters.json"
if az group exists --name "$RG" | grep -qx true; then
  az deployment group validate --resource-group "$RG" --template-file "$ROOT/infrastructure/main.bicep" --parameters "$PARAM" -o json
else
  echo "Resource group $RG not found. Run deploy.sh to create it; local Bicep validation completed."
fi
