// @description('Specifies the name of the key vault.')
// param keyVaultName string

@ description('Specifies the Azure location where the key vault should be created.')
param location string =resourceGroup().location

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.')
param enabledForDiskEncryption bool = false

@description('Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
param enabledForTemplateDeployment bool = false

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string

// param applicationId string 

param objectId string 

@description('names of keyvaults to delploy')
param keyvaultNames array = []

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

var keyVaultAccessPolicies = {
  // applicationId: applicationId
  objectId: objectId
  permissions: {
    secrets: [
      'List'
    ]
  }
  tenantId: tenantId
}

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = [for keyvaultName in keyvaultNames: {
  name: keyvaultName
  location: location
  properties: {
    accessPolicies: [keyVaultAccessPolicies]
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    tenantId: tenantId
    sku: {
      name: skuName
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}]


output location string = location
// output name string =
output resourceGroupName string = resourceGroup().name
// output resourceId string = kv
