/************************************************************************************************************************************************

  Custom Configuration

        Most of the configurations you will want to change for a functional PoC are located here. While you can modify any part of the 
        deployment, you must configure these to fit your existing Azure environment.

************************************************************************************************************************************************/

azure_region                             = "eastus"                               // Region to create all the resources in.
resource_group_name                      = "DEPLOY_PREFIX_NAME-PoC-Synapse-Analytics"                // Resource Group for all related Azure services.
synapse_sql_pool_name                    = "DataWarehouse"                        // Name of the SQL pool to create.
synapse_sql_administrator_login          = "sqladminuser"                         // Native SQL account for administration.
synapse_sql_administrator_login_password = "Pass@word123"                         // Password for the native SQL admin account above.
synapse_azure_ad_admin_upn               = "REPLACE_SYNAPSE_AZURE_AD_ADMIN_UPN"   // UserPrincipcalName (UPN) for the Azure AD administrator of Synapse. This can also be a group, but only one value can be specified. (i.e. stanw@microsoft.com)
adls_storage_account                     = "DEPLOY_PREFIX_NAMEtpcdsacctpoc"                         // Name of Azure Storage Account Gen2
synapse_workspace_name                   = "DEPLOY_PREFIX_NAME-pocsynapseanalytics-tpcds"            // Name of Synapse Workspace
enable_private_endpoints                 = false                                  // If true, create Private Endpoints for Synapse Analytics. This assumes you have other Private Endpoint requirements configured and in place such as virtual networks, VPN/Express Route, and private DNS forwarding.
private_endpoint_virtual_network         = ""                                     // Name of the Virtual Network where you want to create the Private Endpoints. (i.e. vnet-data-platform)
private_endpoint_virtual_network_subnet  = ""                                     // Name of the Subnet within the Virtual Network where you want to create the Private Endpoints. (i.e. private-endpoint-subnet)
databricks_workspace_name                = "DEPLOY_PREFIX_NAME-pocdatabricks-tpcds"                  // Name of Databricks Workspace
key_vault_name                           = "DEPLOY_PREFIX_NAMEpockvtpcdsapp"                  // Name of the key vault
sp_name                                  = "DEPLOY_PREFIX_NAMEpocapp-tpcds"                  // Name of the key vault
