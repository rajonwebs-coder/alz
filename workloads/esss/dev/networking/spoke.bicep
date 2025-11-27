param location string = 'australiaeast'
param spokeVnetName string
param spokeAddressPrefix string
param appSubnetPrefix string
param hubVnetId string

module spokeVnet 'modules/vnet.bicep' = {
  name: '${spokeVnetName}-vnet'
  params: {
    name: spokeVnetName
    location: location
    addressPrefix: spokeAddressPrefix
  }
}

module appSubnet 'modules/subnet.bicep' = {
  name: '${spokeVnetName}-app-subnet'
  params: {
    vnetName: spokeVnetName
    subnetName: 'app'
    prefix: appSubnetPrefix
  }
}

module peering 'modules/peer.bicep' = {
  name: '${spokeVnetName}-hub-peer'
  params: {
    hubVnetId: hubVnetId
    spokeVnetId: spokeVnet.outputs.vnetId
  }
}

output spokeVnetId string = spokeVnet.outputs.vnetId
output appSubnetId string = appSubnet.outputs.subnetId
