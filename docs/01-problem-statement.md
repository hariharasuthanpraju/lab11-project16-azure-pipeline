# Scenario and learning objectives
A company wants isolated Dev, QA, and Production infrastructure deployed consistently in Central India. A single Bicep entry point must consume environment-specific `.bicepparam` files, reuse modules, and produce traceable, repeatable deployments.

## Learning outcomes
1. Build a modular infrastructure template.
2. Understand resource-group deployment scope and module outputs.
3. Deploy separate environments without copy/paste templates.
4. Review What-If changes and repeat deployments safely.
5. Verify network isolation, storage security, tagging and SKU differences.
6. Generate equivalent ARM JSON from Bicep.
7. Optionally deploy a Node.js application on App Service.

## Cost considerations
VNet and NSG configuration alone generally have no hourly charge. Storage incurs usage charges and transaction charges. App Service B1/S1 is billed while provisioned; disabled by default. Production uses Standard_GRS, which costs more than LRS. Review Azure pricing for your subscription and region before enabling paid options. No VMs, gateways, private endpoints, or NAT gateways are deployed.
