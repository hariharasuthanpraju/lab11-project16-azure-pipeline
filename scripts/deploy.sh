#!/usr/bin/env bash
source "$(dirname "$0")/common.sh" "$@"
echo "Subscription: $(az account show --query name -o tsv)"
echo "Environment: $ENV | RG: $RG | Region: $LOCATION"
read -r -p 'Proceed with this subscription and resource group? [y/N] ' confirm
[[ "$confirm" == y || "$confirm" == Y ]] || exit 1
az group create --name "$RG" --location "$LOCATION" --tags lab=lab11-project07 environment="$ENV" -o table
az deployment group validate --resource-group "$RG" --template-file "$ROOT/infrastructure/main.bicep" --parameters "$PARAM" -o none
az deployment group what-if --resource-group "$RG" --template-file "$ROOT/infrastructure/main.bicep" --parameters "$PARAM"
read -r -p 'Apply this What-If plan? [y/N] ' apply
[[ "$apply" == y || "$apply" == Y ]] || exit 0
az deployment group create --name "lab11-p07-${ENV}-$(date +%Y%m%d%H%M%S)" --resource-group "$RG" --template-file "$ROOT/infrastructure/main.bicep" --parameters "$PARAM" --query properties.outputs -o json
