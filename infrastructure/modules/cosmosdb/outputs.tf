# Expose l'endpoint du compte CosmosDB pour qu'il puisse être utilisé par d'autres ressources ou applications.
output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.shop_app_cosmosdb.endpoint # Endpoint du compte CosmosDB.
}

# Expose la clé de lecture seule du compte CosmosDB en tant que sortie sensible.
output "cosmosdb_readonly_key" {
  value     = data.azurerm_cosmosdb_account.shop_app_keys.primary_readonly_key # Clé de lecture seule.
}

# Expose le nom de la base de données CosmosDB pour qu'il puisse être utilisé par d'autres ressources ou applications.
output "cosmosdb_database_name" {
  value = azurerm_cosmosdb_sql_database.shop_app_db.name # Nom de la base de données CosmosDB.
}

# Expose le nom du conteneur CosmosDB pour qu'il puisse être utilisé par d'autres ressources ou applications.
output "cosmosdb_container_name" {
  value = azurerm_cosmosdb_sql_container.shop_app_container.name # Nom du conteneur CosmosDB.
}
