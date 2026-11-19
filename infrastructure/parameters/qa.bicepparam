using '../main.bicep'
param environment = 'qa'
param location = 'centralindia'
param prefix = 'lab11p07'
param deployWeb = false
param webSku = 'B1'
param storageSku = 'Standard_LRS'
param vnetPrefix = '10.42.0.0/16'
param appSubnetPrefix = '10.42.1.0/24'
param dataSubnetPrefix = '10.42.2.0/24'
param tags = { owner: 'training', costCenter: 'LAB11', workload: 'multi-env' }
