param targetId string
param logAnalyticsWorkspaceId string

resource diag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'diag-settings'
  scope: targetId
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        category: 'NetworkSecurityGroupRuleCounter'
        enabled: true
      }
    ]
  }
}
