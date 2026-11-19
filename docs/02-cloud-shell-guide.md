# Azure Cloud Shell: exact hands-on deployment

## Prerequisites
- Standard Azure subscription with Contributor rights to create resource groups and deploy resources.
- Azure Portal → Cloud Shell → Bash, with Azure CLI and Bicep available.
- Upload ZIP using Cloud Shell **Manage files → Upload**.

## Commands
```bash
unzip LAB11-Project07-Multi-Environment-Deployment.zip
cd LAB11-Project07-Multi-Environment-Deployment
chmod +x scripts/*.sh
az account list -o table
az account set --subscription '<SUBSCRIPTION_ID>'
az account show -o table
az bicep upgrade
bash scripts/deploy.sh dev
bash scripts/verify.sh dev
bash scripts/deploy.sh qa
bash scripts/verify.sh qa
bash scripts/deploy.sh prod
bash scripts/verify.sh prod
```
Each deploy creates its resource group, validates, shows What-If, and requests approval before applying. Run sequentially to review costs.

## Local compile / ARM conversion
```bash
bash scripts/validate.sh dev
bash scripts/export-arm.sh dev
ls -lh arm/generated/
```

## Optional paid App Service
Edit `infrastructure/parameters/dev.bicepparam`: `param deployWeb = true`. Keep `webSku = 'B1'` for Linux hosting; deploy again, then:
```bash
bash scripts/deploy.sh dev
bash scripts/deploy-app.sh dev
APP=$(az webapp list -g rg-lab11-p07-dev --query '[0].defaultHostName' -o tsv)
curl -fsS "https://$APP/health"
```
App Service is NOT integrated into the VNet by default. This lab is about IaC modularity, not private connectivity.

## Idempotency exercise
Run `bash scripts/deploy.sh dev` a second time. Inspect What-If: it should show no material changes when parameters remain unchanged. Deployment records may still be created.

## Cleanup
```bash
bash scripts/cleanup.sh prod
bash scripts/cleanup.sh qa
bash scripts/cleanup.sh dev
```
Deletion is asynchronous; monitor Resource Groups in Portal until gone.
