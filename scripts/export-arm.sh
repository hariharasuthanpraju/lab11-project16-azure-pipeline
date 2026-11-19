#!/usr/bin/env bash
source "$(dirname "$0")/common.sh" "$@"
mkdir -p "$ROOT/arm/generated"
az bicep build --file "$ROOT/infrastructure/main.bicep" --outfile "$ROOT/arm/generated/main.json"
az bicep build-params --file "$PARAM" --outfile "$ROOT/arm/generated/${ENV}.parameters.json"
echo "Generated ARM template and parameters in arm/generated/. Do not edit generated JSON; edit Bicep sources."
