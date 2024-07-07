 @description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Get it by using Get-AzSubscription cmdlet.')
param tenantId string = subscription().tenantId

param applicationId string 

param objectId string 



module keyvault 'modules/keyvault.bicep' = {
  name: 'deploy-${keyVaultName}'
  params: {
    keyVaultName: keyVaultName
    location: location
    tenantId: tenantId
    objectId: objectId
    applicationId: applicationId

  }
}


output location string = location
output name string = keyvault.outputs.name
output resourceGroupName string = resourceGroup().name
output resourceId string = keyvault.outputs.resourceId
