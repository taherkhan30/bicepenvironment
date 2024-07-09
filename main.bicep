

@description('Location of the resources')
param location string = 'westeurope'

@description('tags for resources')
param tags object = {}

@minLength(3)
@maxLength(24)
@description('name of the storage account')
param storageAccountName string 

@minLength(3)
@maxLength(24)
@description('name of the audit storage account')
param auditstorageAccountName string 

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('sku of storage account')
param storageAccountSku string 

param supportHttpsTraffic bool = true


module storageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${storageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

var auditStorageAccountContainers = [
  'data'
  'logs'
]

module auditstorageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${auditstorageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
    containerNames: auditStorageAccountContainers
  }
}


output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountId string = storageAccount.outputs.storageAccountId
output auditstorageAccountName string = storageAccount.outputs.storageAccountName
output auditstorageAccountId string = storageAccount.outputs.storageAccountId
// 1f293866-37c7-4e47-a204-4ce84b1574a7 infrastrucutre sc service connection 



