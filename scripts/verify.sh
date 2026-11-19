#!/usr/bin/env bash
source "$(dirname "$0")/common.sh" "$@"
echo '=== Resource inventory ==='
az resource list -g "$RG" --query '[].{name:name,type:type,location:location}' -o table
echo '=== VNet / subnet ==='
az network vnet show -g "$RG" -n "vnet-lab11-${ENV}" --query '{name:name,addressSpace:addressSpace.addressPrefixes,subnets:subnets[].name}' -o json
echo '=== NSG rules ==='
az network nsg rule list -g "$RG" --nsg-name "nsg-lab11-${ENV}-app" --query '[].{name:name,priority:priority,access:access,direction:direction}' -o table
echo '=== Storage security ==='
for name in $(az storage account list -g "$RG" --query '[].name' -o tsv); do
 az storage account show -g "$RG" -n "$name" --query '{name:name,sku:sku.name,httpsOnly:enableHttpsTrafficOnly,minTls:minimumTlsVersion,publicBlob:allowBlobPublicAccess,sharedKey:allowSharedKeyAccess}' -o json
done
echo '=== Web apps (if enabled) ==='
az webapp list -g "$RG" --query '[].{name:name,host:defaultHostName,state:state}' -o table
