# Screenshot evidence — simulated references, not actual portal screenshots

The images in `screenshots/simulated/` are **clearly labeled schematic mockups** for teaching. They do not represent actual Azure Portal results. For real evidence, deploy resources and capture the corresponding Azure Portal screens:

| Screenshot | Portal blade | Verify |
|---|---|---|
| 01 | Resource groups | Dev, QA, Prod groups |
| 02 | Dev VNet Overview | VNet name and region |
| 03 | Dev VNet Subnets | App and data subnet CIDRs |
| 04 | Dev NSG Inbound rules | Deny rule priority 200 |
| 05 | Dev Storage Overview | Standard LRS |
| 06 | Dev Storage Configuration | HTTPS/TLS settings |
| 07 | QA Resource group | QA isolation |
| 08 | QA VNet | 10.42.0.0/16 |
| 09 | Prod Storage Overview | Standard GRS |
| 10 | Resource tags | Common and environment tags |
| 11 | Resource group Deployments | Successful deployment history |
| 12 | Cloud Shell What-If | No material changes after repeat deployment |

Store actual captures under `screenshots/actual/` and never include secrets, tenant identifiers or personal information in public repositories.
