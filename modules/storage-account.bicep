

@description('Location of the resources')
param location string = 'westeurope'

@description('tags for resources')
param tags object = {}

@minLength(3)
@maxLength(24)
@description('name of the storage account')
param storageAccountName string 


@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('sku of storage account')
param storageAccountSku string 

param supportHttpsTraffic bool = true

var storageAccountKind = 'Storagev2'

var storageAccountProperties = {
  minimumTlsVersion: 'TLS1_2'
  supportsHttpsTrafficOnly: supportHttpsTraffic

}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  tags: tags 
  location: location 
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}


output storageAccountName string = storageAccountName
output storageAccountId string = storageAccount.id
