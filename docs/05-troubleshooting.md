# Troubleshooting playbook

| Symptom | Likely cause | Fix |
|---|---|---|
| `AuthorizationFailed` | Subscription permissions insufficient | Confirm subscription, Contributor role, provider registration |
| `MissingSubscriptionRegistration` | Resource provider unregistered | `az provider register --namespace Microsoft.Network`; repeat for Storage/Web |
| `RequestDisallowedByPolicy` | Azure Policy restricts SKU/location | Review policy details; choose permitted SKU/region in parameters |
| `LocationNotAvailableForResourceType` | Region/SKU unsupported | Check `az account list-locations` and SKU availability; change location consistently |
| `StorageAccountAlreadyTaken` | Global name collision | Change `prefix` in environment parameter file |
| `InvalidTemplate` | Bicep/ARM error | `az bicep build -f infrastructure/main.bicep` and inspect diagnostics |
| `SubnetRangesOverlap` | Invalid address prefixes | Ensure subnets fit VNet and do not overlap |
| `QuotaExceeded` | App Service quota | Leave `deployWeb=false`, use eligible SKU or another region |
| `Web app startup failure` | App runtime/package | Review Log stream, `az webapp log tail`; verify Node 20 and `package.json` |
| What-If unexpected changes | Parameter drift or API normalization | Compare parameters, inspect resource changes before approving |
| `zip: command not found` | ZIP utility unavailable | `sudo apt-get install zip` where allowed, or zip locally |
| Resource deletion slow | Asynchronous deletion | `az group exists -n <name>` until false |

**Security:** No passwords, access keys or connection strings are included. Shared key access is disabled on storage; use Microsoft Entra ID for data-plane access if you extend the lab.
