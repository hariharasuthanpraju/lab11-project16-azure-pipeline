# 12 hands-on test scenarios

| # | Test | Procedure | Expected result |
|---|---|---|---|
| 01 | Compile Bicep | `az bicep build -f infrastructure/main.bicep --outfile /tmp/p07.json` | Exit code 0 |
| 02 | Parameter compilation | `az bicep build-params -f infrastructure/parameters/dev.bicepparam --outfile /tmp/dev.json` | Valid JSON |
| 03 | Dev deployment | `bash scripts/deploy.sh dev` | Deployment succeeds |
| 04 | Dev VNet | `az network vnet show -g rg-lab11-p07-dev -n vnet-lab11-dev --query addressSpace.addressPrefixes` | `10.41.0.0/16` |
| 05 | Dev NSG | `az network nsg rule list -g rg-lab11-p07-dev --nsg-name nsg-lab11-dev-app -o table` | Deny rule priority 200 |
| 06 | Storage security | `bash scripts/verify.sh dev` | HTTPS, TLS1.2, no public blob or shared keys |
| 07 | QA isolation | `bash scripts/deploy.sh qa` | Separate QA resource group |
| 08 | Prod storage SKU | `bash scripts/deploy.sh prod && bash scripts/verify.sh prod` | Standard_GRS |
| 09 | Idempotency | Redeploy Dev unchanged | What-If no material changes |
| 10 | Change detection | Change Dev tag, run What-If | Tag change detected; revert afterward |
| 11 | ARM export | `bash scripts/export-arm.sh dev` | Generated ARM JSON files |
| 12 | Cleanup | `bash scripts/cleanup.sh qa` | QA resource group deletion starts |

## Negative tests
- Change `environment` to an unsupported value in a copied parameter file: compilation or validation should reject it.
- Set overlapping subnet CIDRs: Azure networking validation should reject it. Restore valid ranges.
- Try an invalid storage SKU: Bicep `@allowed` or ARM validation should reject it.

Capture real evidence in `screenshots/actual/` if desired. Simulated references in `screenshots/simulated/` are NOT Azure Portal captures.
