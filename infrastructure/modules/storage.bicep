param name string
param location string
param sku string
param tags object
resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: location
  tags: tags
  sku: { name: sku }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
    publicNetworkAccess: 'Enabled'
    networkAcls: { bypass: 'AzureServices', defaultAction: 'Allow' }
  }
}
output storageName string = storage.name
output storageId string = storage.id
