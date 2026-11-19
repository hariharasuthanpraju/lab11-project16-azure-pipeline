using '../main.bicep'
param environment = 'prod'
param location = 'centralindia'
param prefix = 'lab11p07'
param deployWeb = false
param webSku = 'S1'
param storageSku = 'Standard_GRS'
param vnetPrefix = '10.43.0.0/16'
param appSubnetPrefix = '10.43.1.0/24'
param dataSubnetPrefix = '10.43.2.0/24'
param tags = { owner: 'training', costCenter: 'LAB11', workload: 'multi-env' }
