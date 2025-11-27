param name string
param location string
param addressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2022-09-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
  }
}

output vnetId string = vnet.id
