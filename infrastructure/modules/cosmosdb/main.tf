resource "azurerm_cosmosdb_account" "shop_app_cosmosdb" {
  name                             = var.cosmosdb_account_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  offer_type                       = "Standard"
  kind                             = "GlobalDocumentDB"
  is_virtual_network_filter_enabled = true
  public_network_access_enabled     = true

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  virtual_network_rule {
    id = var.cosmosdb_subnet_id
  }

  ip_range_filter = var.authorized_ips
}

resource "azurerm_cosmosdb_sql_database" "shop_app_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.shop_app_cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "shop_app_container" {
  name                = var.container_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.shop_app_cosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.shop_app_db.name
  partition_key_paths = ["/partitionKey"]
  throughput          = 400
}

data "azurerm_cosmosdb_account" "shop_app_keys" {
  name                = azurerm_cosmosdb_account.shop_app_cosmosdb.name
  resource_group_name = var.resource_group_name
}

