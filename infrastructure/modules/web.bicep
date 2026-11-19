param location string
param name string
param environment string
param sku string
param tags object
param storageName string
resource plan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'asp-lab11-${environment}'
  location: location
  tags: tags
  kind: 'linux'
  sku: { name: sku, tier: sku == 'F1' ? 'Free' : sku == 'B1' ? 'Basic' : 'Standard' }
  properties: { reserved: true }
}
resource app 'Microsoft.Web/sites@2023-12-01' = {
  name: name
  location: location
  tags: tags
  kind: 'app,linux'
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'NODE|20-lts'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      appSettings: [
        { name: 'ENVIRONMENT', value: environment }
        { name: 'STORAGE_ACCOUNT', value: storageName }
        { name: 'WEBSITE_NODE_DEFAULT_VERSION', value: '~20' }
      ]
    }
  }
}
output webAppName string = app.name
output webAppUrl string = 'https://${app.properties.defaultHostName}'
