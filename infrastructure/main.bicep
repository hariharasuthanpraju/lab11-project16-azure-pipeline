targetScope = 'resourceGroup'
@description('Deployment environment')
@allowed(['dev','qa','prod'])
param environment string
@description('Location for all resources')
param location string = resourceGroup().location
@description('Globally unique prefix; lowercase letters/numbers, 3-12 characters')
@minLength(3)
@maxLength(12)
param prefix string
@description('Deploy App Service plan and web app (paid; default false)')
param deployWeb bool = false
@allowed(['F1','B1','S1'])
param webSku string = 'B1'
@allowed(['Standard_LRS','Standard_GRS','Standard_ZRS'])
param storageSku string = 'Standard_LRS'
@description('Subnet CIDR for app tier')
param appSubnetPrefix string
@description('Subnet CIDR for data tier')
param dataSubnetPrefix string
@description('VNet CIDR')
param vnetPrefix string
param tags object = {}
var commonTags = union(tags, {environment: environment, managedBy: 'bicep', lab: 'lab11-project07'})
var uniqueSuffix = take(uniqueString(subscription().id, resourceGroup().id, environment), 6)
var storageName = toLower('${prefix}${environment}${uniqueSuffix}')
var appName = toLower('${prefix}-${environment}-${uniqueSuffix}-web')
module network './modules/network.bicep' = {
  name: 'network-${environment}'
  params: {
    location: location
    environment: environment
    vnetPrefix: vnetPrefix
    appSubnetPrefix: appSubnetPrefix
    dataSubnetPrefix: dataSubnetPrefix
    tags: commonTags
  }
}
module storage './modules/storage.bicep' = {
  name: 'storage-${environment}'
  params: {
    name: storageName
    location: location
    sku: storageSku
    tags: commonTags
  }
}
module web './modules/web.bicep' = if (deployWeb) {
  name: 'web-${environment}'
  params: {
    location: location
    name: appName
    environment: environment
    sku: webSku
    tags: commonTags
    storageName: storage.outputs.storageName
  }
}
output environmentName string = environment
output storageAccountName string = storage.outputs.storageName
output vnetName string = network.outputs.vnetName
output appSubnetId string = network.outputs.appSubnetId
output webAppName string = deployWeb ? web.outputs.webAppName : 'not-deployed'
output webAppUrl string = deployWeb ? web.outputs.webAppUrl : 'not-deployed'
