

@description('name')
param storageAccountNames array

param adGroupId string

param roleAssignmentId string

resource role 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' existing = {
  
  name: roleAssignmentId

}

// var roleName = role.id

// resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
//   name: storageAccountName
// }

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
}]

//indexed loop 
resource roleAssignments 'Microsoft.Storage/storageAccounts@2023-05-01' = [for i in range(0,length(storageAccountNames)): {
  name: guid(storageAccount[i].id, role.id, adGroupId )
  scope: storageAccount[i]
  properties: {
    principalId: role.id 
    roleDefinitionId: adGroupId
}}]

// resource roleAssignment 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
//   name: guid(storageAccountName, role.id, adGroupId )
//   scope: storageAccount
//   properties: {
//     principalId: role.id 
//     roleDefinitionId: adGroupId

//   }
// }
