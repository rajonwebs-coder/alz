param hubVnetId string
param spokeVnetId string

resource hubToSpoke 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-09-01' = {
  name: '${last(split(hubVnetId, "/"))}-to-${last(split(spokeVnetId, "/"))}'
  scope: resourceGroup()
  properties: {
    remoteVirtualNetwork: { id: spokeVnetId }
    allowForwardedTraffic: true
    allowGatewayTransit: true
  }
}

resource spokeToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-09-01' = {
  name: '${last(split(spokeVnetId, "/"))}-to-${last(split(hubVnetId, "/"))}'
  scope: resourceGroup()
  properties: {
    remoteVirtualNetwork: { id: hubVnetId }
    allowForwardedTraffic: true
    useRemoteGateways: true
  }
}
