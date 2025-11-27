param location string = 'australiaeast'
param environment string = 'dev'
param workloadName string
param vmSize string
param adminUsername string
param adminPassword string
param osDiskSizeGB int
param dataDiskSizeGB int
param subnetId string
param logAnalyticsWorkspaceId string
param enablePublicIp bool = false

module pip 'modules/pip.bicep' = if (enablePublicIp) {
  name: '${workloadName}-pip'
  params: {
    name: '${workloadName}-pip'
    location: location
  }
}

module nic 'modules/nic.bicep' = {
  name: '${workloadName}-nic'
  params: {
    name: '${workloadName}-nic'
    location: location
    subnetId: subnetId
    publicIpId: enablePublicIp ? pip.outputs.publicIpId : null
  }
}

module nsg 'modules/nsg.bicep' = {
  name: '${workloadName}-nsg'
  params: {
    name: '${workloadName}-nsg'
    location: location
    nicName: nic.outputs.nicName
  }
}

module vm 'modules/vm.bicep' = {
  name: workloadName
  params: {
    vmName: workloadName
    vmSize: vmSize
    adminUsername: adminUsername
    adminPassword: adminPassword
    nicId: nic.outputs.nicId
    location: location
    osDiskSizeGB: osDiskSizeGB
  }
}

module disks 'modules/disks.bicep' = {
  name: '${workloadName}-data-disks'
  params: {
    vmName: workloadName
    location: location
    dataDiskSizeGB: dataDiskSizeGB
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: '${workloadName}-monitoring'
  params: {
    vmId: vm.outputs.vmId
    logAnalyticsWorkspaceId: logAnalyticsWorkspaceId
  }
}

output vmId string = vm.outputs.vmId
