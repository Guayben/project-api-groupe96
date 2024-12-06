output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.shop_app_cosmosdb.endpoint
}

output "cosmosdb_readonly_key" {
  value     = data.azurerm_cosmosdb_account.shop_app_keys.primary_readonly_key
}

output "cosmosdb_database_name" {
  value = azurerm_cosmosdb_sql_database.shop_app_db.name
}

output "cosmosdb_container_name" {
  value = azurerm_cosmosdb_sql_container.shop_app_container.name
}
