param location string
param vnetName string

var gatewaySubnet = 'GatewaySubnet'

resource publicIP 'Microsoft.Network/publicIPAddresses@2022-09-01' = {
  name: '${vnetName}-gw-pip'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

resource vpnGw 'Microsoft.Network/virtualNetworkGateways@2022-09-01' = {
  name: '${vnetName}-vpngw'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'gwipconfig'
        properties: {
          publicIPAddress: { id: publicIP.id }
          subnet: { id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, gatewaySubnet) }
        }
      }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    sku: {
      name: 'VpnGw1'
    }
  }
}
