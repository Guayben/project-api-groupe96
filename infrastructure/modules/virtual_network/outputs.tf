# Expose l'ID du réseau virtuel pour une utilisation ultérieure.
output "vnet_id" {
  value = azurerm_virtual_network.shop_app_vnet.id # ID du réseau virtuel.
}

# Expose l'ID du sous-réseau destiné à l'application web pour une utilisation ultérieure.
output "app_service_subnet_id" {
  value = azurerm_subnet.app_service_subnet.id # ID du sous-réseau pour l'application web.
}

# Expose l'ID du sous-réseau destiné à CosmosDB pour une utilisation ultérieure.
output "cosmosdb_subnet_id" {
  value = azurerm_subnet.cosmosdb_subnet.id # ID du sous-réseau pour CosmosDB.
}
