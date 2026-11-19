# LAB 11 — Project 07: Multi-Environment Azure Deployment with Bicep

**Region:** Central India (`centralindia`)  
**Subscription:** Standard Azure subscription  
**Environments:** Dev, QA, Prod  
**IaC:** Modular Bicep + generated ARM JSON  
**Default deployment:** VNet + 2 subnets + NSG + secure Storage Account per environment  
**Optional paid component:** Linux App Service + sample Node.js web app (disabled by default)

## Quick start (Azure Cloud Shell Bash)
```bash
unzip LAB11-Project07-Multi-Environment-Deployment.zip
cd LAB11-Project07-Multi-Environment-Deployment
chmod +x scripts/*.sh
az account list -o table
az account set --subscription '<YOUR_SUBSCRIPTION_ID>'
export LOCATION=centralindia
bash scripts/deploy.sh dev
bash scripts/verify.sh dev
bash scripts/deploy.sh qa
bash scripts/verify.sh qa
bash scripts/deploy.sh prod
bash scripts/verify.sh prod
```
Deployment is interactive: confirms subscription/RG, shows What-If and asks for approval. Check all costs before proceeding. Three storage accounts will incur usage charges; `prod` defaults to GRS.

## File structure
- `infrastructure/main.bicep`: entry point and module wiring
- `infrastructure/modules/`: reusable network, storage, web modules
- `infrastructure/parameters/`: `.bicepparam` files for Dev, QA, Prod
- `scripts/`: validate, deploy, verify, export ARM, deploy app, cleanup
- `application/`: optional Node.js sample web application
- `arm/generated/`: generated ARM JSON (created by export script)
- `docs/`: seven detailed labs and operations guides
- `diagrams/`: three Mermaid architecture diagrams
- `screenshots/simulated/`: labeled simulated illustrations; **not real Azure screenshots**
- `.github/workflows/validate.yml`: offline CI compilation checks

## ARM template export
```bash
bash scripts/export-arm.sh dev
```
This generates an ARM JSON template and parameter JSON from the Bicep source. The source of truth is Bicep. ARM JSON is generated instead of hand-maintained to avoid drift.

## Optional sample application
Edit `infrastructure/parameters/dev.bicepparam`: `param deployWeb = true`, keep B1; then run:
```bash
bash scripts/deploy.sh dev
bash scripts/deploy-app.sh dev
APP=$(az webapp list -g rg-lab11-p07-dev --query '[0].defaultHostName' -o tsv)
curl -fsS "https://${APP}/health"
```
**Costs:** B1 and S1 App Service plans are billable. Storage and bandwidth are billable. The optional Web App does not use VNet integration or private endpoints.

## Clean up
```bash
bash scripts/cleanup.sh prod
bash scripts/cleanup.sh qa
bash scripts/cleanup.sh dev
```
Each cleanup requires typing the exact RG name. Resource group deletion is asynchronous.

## Documentation
Start with [problem statement](docs/01-problem-statement.md), [Cloud Shell guide](docs/02-cloud-shell-guide.md), [Portal exercises](docs/03-portal-exercises.md), [12 test scenarios](docs/04-test-scenarios.md), [troubleshooting](docs/05-troubleshooting.md), [operations](docs/06-operations-verification.md), and [screenshot guide](docs/07-azure-portal-screenshot-guide.md).

## Limitations
- No live Azure deployment was performed while preparing this repository. Validate and test in your own subscription.
- Portal screenshots are schematic/simulated references, not actual captures.
- Some subscriptions may restrict storage replication options, App Service SKUs or resource providers in Central India. Review What-If and adjust `.bicepparam` accordingly.
- Network resources are logically separate by RG and VNet; there is no VNet peering, firewall or cross-environment connectivity.
