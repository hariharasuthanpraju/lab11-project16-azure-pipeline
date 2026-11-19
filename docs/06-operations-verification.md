# Operational verification checklist

```bash
az account show --query '{subscription:id,name:name}' -o json
az group list --query "[?starts_with(name,'rg-lab11-p07-')].{name:name,location:location}" -o table
az deployment group list -g rg-lab11-p07-dev --query '[].{name:name,state:properties.provisioningState}' -o table
az resource list -g rg-lab11-p07-dev -o table
az network vnet subnet list -g rg-lab11-p07-dev --vnet-name vnet-lab11-dev -o table
az network nsg rule list -g rg-lab11-p07-dev --nsg-name nsg-lab11-dev-app -o table
az storage account list -g rg-lab11-p07-dev --query '[].{name:name,sku:sku.name,tls:minimumTlsVersion,https:enableHttpsTrafficOnly}' -o table
az resource list -g rg-lab11-p07-dev --query '[].{name:name,tags:tags}' -o json
az consumption budget list --resource-group rg-lab11-p07-dev -o table
```

Note: budget APIs may require additional permissions and may not be available for every billing account. Use Cost Management → Cost analysis → filter by resource group for a manual alternative. Billing data is delayed; it is not a real-time cost meter.

## Production review
- Ensure no public access is accidentally granted to Blob data.
- Confirm Web App remains disabled unless deliberately enabled.
- Compare environment-specific storage redundancy and tags.
- Inspect Activity log and Deployment history for troubleshooting.
- Review costs before enabling B1/S1 web hosting or additional redundancy.
