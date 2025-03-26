//https://johnnyreilly.com/output-connection-strings-and-keys-from-azure-bicep


param location string = resourceGroup().location
param myindentity string
param privateIP string

var abbrs = loadJsonContent('./abbreviations.json')
var storage_acc_name =  '${abbrs.storageStorageAccounts}${uniqueString(resourceGroup().id)}'
var cosmos_acc_name=  'cosmos${uniqueString(resourceGroup().id)}'
var keyvault_acc_name=  '${abbrs.keyVaultVaults}${uniqueString(resourceGroup().id)}'
var sperimeters_acc_name = 'sp${uniqueString(resourceGroup().id)}'
var sqlserver_acc_name = '${abbrs.sqlServers}${uniqueString(resourceGroup().id)}'
var cosmos_acc_name_db = '${cosmos_acc_name}db'
var sqlserver_acc_name_db = '${sqlserver_acc_name}db'



// param vulnerabilityAssessments_Default_storageContainerPath string
// param sqlserver_acc_name string = 'sfitestalex'
// param vaults_sfitestalex_name string = 'sfitestalex'
// param storage_acc_name string = 'sfitestalex'
// param databaseAccounts_sfitestalex_name string = 'sfitestalex'
// param sperimeters_acc_name string = 'sfitest'
// param systemTopics_sfitestalex_c4d8e5dd_56cc_4795_a374_7127b1d70ec4_name string = 'sfitestalex-c4d8e5dd-56cc-4795-a374-7127b1d70ec4'

resource cosmosdb 'Microsoft.DocumentDB/databaseAccounts@2024-12-01-preview' = {
  name: cosmos_acc_name
  location: location
  tags: {
    defaultExperience: 'Core (SQL)'
    'hidden-workload-type': 'Learning'
    'hidden-cosmos-mmspecial': ''
  }
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'None'
  }
  properties: {
    publicNetworkAccess: 'Disabled'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableAnalyticalStorage: false
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    databaseAccountOfferType: 'Standard'
    enableMaterializedViews: false
    capacityMode: 'Serverless'
    defaultIdentity: 'FirstPartyIdentity'
    networkAclBypass: 'None'
    disableLocalAuth: false
    enablePartitionMerge: false
    enablePerRegionPerPartitionAutoscale: false
    enableBurstCapacity: false
    enablePriorityBasedExecution: false
    minimalTlsVersion: 'Tls12'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    cors: []
    capabilities: []
    ipRules: []
    backupPolicy: {
      type: 'Periodic'
      periodicModeProperties: {
        backupIntervalInMinutes: 240
        backupRetentionIntervalInHours: 8
        backupStorageRedundancy: 'Geo'
      }
    }
    networkAclBypassResourceIds: []
    diagnosticLogSettings: {
      enableFullTextQuery: 'None'
    }
    capacity: {
      totalThroughputLimit: 4000
    }
  }
}

resource keyvault 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: keyvault_acc_name
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    networkAcls: {
      bypass: 'None'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Disabled'
  }
}

resource sperimeters 'Microsoft.Network/networkSecurityPerimeters@2023-08-01-preview' = {
  name: sperimeters_acc_name
  location: location
  properties: {}
}

resource sqlserver'Microsoft.Sql/servers@2024-05-01-preview' = {
  name: sqlserver_acc_name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'User'
      login: myindentity
      sid: myindentity
      tenantId: tenant().tenantId
      azureADOnlyAuthentication: true
    }
    restrictOutboundNetworkAccess: 'Disabled'
    
  }
}

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storage_acc_name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    isHnsEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource cosmosdb_db 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-12-01-preview' = {
  parent: cosmosdb
  name: cosmos_acc_name_db
  properties: {
    resource: {
      id: cosmos_acc_name_db
    }
  }
}

resource cosmos_role1 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2024-12-01-preview' = {
  parent: cosmosdb
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      cosmosdb.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource cosmos_role2 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2024-12-01-preview' = {
  parent: cosmosdb
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      cosmosdb.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource table_role1 'Microsoft.DocumentDB/databaseAccounts/tableRoleDefinitions@2024-12-01-preview' = {
  parent: cosmosdb
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      cosmosdb.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/entities/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource table_role2 'Microsoft.DocumentDB/databaseAccounts/tableRoleDefinitions@2024-12-01-preview' = {
  parent: cosmosdb
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      cosmosdb.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/tables/*'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/tables/containers/entities/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource sperimeters_profile 'Microsoft.Network/networkSecurityPerimeters/profiles@2023-08-01-preview' = {
  parent: sperimeters
  name: 'userProfile'
  location: location
  properties: {}
}

resource sqlserver_acc_name_ActiveDirectory 'Microsoft.Sql/servers/administrators@2024-05-01-preview' = {
  parent: sqlserver
  name: 'ActiveDirectory'
  properties: {
    administratorType: 'ActiveDirectory'
    login: myindentity
    sid: myindentity
    tenantId: tenant().tenantId
  }
}

resource sqlserver_acc_name_TestDB 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
  parent: sqlserver
  name: sqlserver_acc_name_db
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Local'
     isLedgerOn: false
    availabilityZone: 'NoPreference'
  }
}

resource storage_acc_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storage
  name: 'default'
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storage_acc_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storage
  name: 'default'
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource queueServices_storage_acc_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storage
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource tableServices_storage_acc_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storage
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource cosmosdb_db_test 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-12-01-preview' = {
  parent: cosmosdb_db
  name: 'test'
  properties: {
    resource: {
      id: 'test'
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
      partitionKey: {
        paths: [
          '/id'
        ]
        kind: 'Hash'
        version: 2
      }
      uniqueKeyPolicy: {
        uniqueKeys: []
      }
      conflictResolutionPolicy: {
        mode: 'LastWriterWins'
        conflictResolutionPath: '/_ts'
      }
      computedProperties: []
    }
  }
}

resource sperimeters_profile_LocalAddress 'Microsoft.Network/networkSecurityPerimeters/profiles/accessRules@2023-08-01-preview' = {
  parent: sperimeters_profile
  name: 'LocalAddress'
  properties: {
    direction: 'Inbound'
    addressPrefixes: [
      privateIP
    ]
    fullyQualifiedDomainNames: []
    subscriptions: []
    emailAddresses: []
    phoneNumbers: []
  }
}

resource spstorage 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  parent: sperimeters
  name: '${sperimeters_acc_name}str'
  properties: {
    privateLinkResource: {
      id: storage.id
    }
    profile: {
      id: sperimeters_profile.id
    }
    accessMode: 'Learning'
  }
}

resource spkeyvault 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  parent: sperimeters
  name: '${sperimeters_acc_name}keyvault'
  properties: {
    privateLinkResource: {
      id: keyvault.id
    }
    profile: {
      id: sperimeters_profile.id
    }
    accessMode: 'Learning'
  }
}

resource spsql 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  parent: sperimeters
  name: '${sperimeters_acc_name}sql'
  properties: {
    privateLinkResource: {
      id: sqlserver.id
    }
    profile: {
      id: sperimeters_profile.id
    }
    accessMode: 'Learning'
  }
}


resource spcosmos 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  parent: sperimeters
  name: '${sperimeters_acc_name}cosmos'
  properties: {
    privateLinkResource: {
      id: cosmosdb.id
    }
    profile: {
      id: sperimeters_profile.id
    }
    accessMode: 'Learning'
  }
}

output KEYVAULT_ID string = keyvault.id
output BLOB_ID string = storage.id
output COSMOS_NAME string = cosmos_acc_name
output COSMOS_ROLE1 string = cosmos_role1.id
output COSMOS_ROLE2 string = cosmos_role2.id
output USER string = myindentity
