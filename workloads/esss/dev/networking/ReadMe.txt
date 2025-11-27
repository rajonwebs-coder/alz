Deploy Hub


az deployment group create \
  --resource-group rg-networking-hub \
  --template-file hub/hub.bicep \
  --parameters logAnalyticsWorkspaceId="/subscriptions/.../workspace"
  
  ===============
  Deploy Spoke (ESS Dev)
  
  
az deployment group create \
  --resource-group rg-esss-dev-network \
  --template-file spoke/spoke.bicep \
  --parameters spokeVnetName="vnet-esss-dev" \
               spokeAddressPrefix="10.10.0.0/16" \
               appSubnetPrefix="10.10.1.0/24" \
               hubVnetId="/subscriptions/.../hub-vnet-id"