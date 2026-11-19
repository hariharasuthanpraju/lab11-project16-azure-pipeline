param location string
param environment string
param vnetPrefix string
param appSubnetPrefix string
param dataSubnetPrefix string
param tags object
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-11-01' = {
  name: 'nsg-lab11-${environment}-app'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'Deny-Internet-Inbound'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: 'vnet-lab11-${environment}'
  location: location
  tags: tags
  properties: {
    addressSpace: { addressPrefixes: [vnetPrefix] }
    subnets: [
      {
        name: 'snet-app'
        properties: {
          addressPrefix: appSubnetPrefix
          networkSecurityGroup: { id: nsg.id }
        }
      }
      {
        name: 'snet-data'
        properties: { addressPrefix: dataSubnetPrefix }
      }
    ]
  }
}
output vnetName string = vnet.name
output appSubnetId string = '${vnet.id}/subnets/snet-app'
