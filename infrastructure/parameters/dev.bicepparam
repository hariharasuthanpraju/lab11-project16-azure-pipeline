using '../main.bicep'
param environment = 'dev'
param location = 'centralindia'
param prefix = 'lab11p07'
param deployWeb = false
param webSku = 'B1'
param storageSku = 'Standard_LRS'
param vnetPrefix = '10.41.0.0/16'
param appSubnetPrefix = '10.41.1.0/24'
param dataSubnetPrefix = '10.41.2.0/24'
param tags = { owner: 'training', costCenter: 'LAB11', workload: 'multi-env' }
