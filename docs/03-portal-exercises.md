# Azure Portal manual exercises

1. **Subscription:** Azure Portal → Subscriptions → select subscription. Confirm subscription ID matches `az account show`.
2. **Resource groups:** search Resource groups → find `rg-lab11-p07-dev`, `...-qa`, `...-prod`. Open each and check location `Central India`.
3. **VNet:** in Dev RG select `vnet-lab11-dev` → Address space → `10.41.0.0/16`.
4. **Subnets:** VNet → Subnets → `snet-app` (`10.41.1.0/24`) and `snet-data` (`10.41.2.0/24`).
5. **NSG:** select `nsg-lab11-dev-app` → Inbound security rules → `Deny-Internet-Inbound`, priority 200.
6. **Storage:** select Dev storage account → Overview → Standard LRS; Settings → Configuration → secure transfer required, minimum TLS 1.2, anonymous blob access disabled.
7. **QA comparison:** QA VNet uses `10.42.0.0/16`, with independent resources.
8. **Prod comparison:** Prod VNet uses `10.43.0.0/16`; storage uses Standard GRS.
9. **Tags:** each resource → Tags → environment, managedBy, lab, costCenter.
10. **Deployments:** Resource Group → Deployments → select recent deployment → Outputs and Template.
11. **What-If:** Cloud Shell run `az deployment group what-if -g rg-lab11-p07-dev -f infrastructure/main.bicep -p infrastructure/parameters/dev.bicepparam`.
12. **Cleanup:** Resource Groups → select lab group → Delete resource group; confirm exact name. Or use scripts.

**Manual alternative exercise:** Azure Portal → Deploy a custom template → Build your own template in editor → paste `arm/generated/main.json` after running `scripts/export-arm.sh`. Supply values from the generated parameters JSON. Use a separate throwaway resource group and avoid duplicate naming collisions. Azure Portal support for ARM parameter JSON varies by workflow; Cloud Shell is the preferred reproducible path.
