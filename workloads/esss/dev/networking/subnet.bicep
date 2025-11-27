param vnetName string
param subnetName string
param prefix string

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-09-01' = {
  name: '${vnetName}/${subnetName}'
  properties: {
    addressPrefix: prefix
  }
}

output subnetId string = subnet.id
