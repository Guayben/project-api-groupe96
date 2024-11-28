output "vnet_id" {
  value = azurerm_virtual_network.shop_app_vnet.id
}

output "app_service_subnet_id" {
  value = azurerm_subnet.app_service_subnet.id
}

output "cosmosdb_subnet_id" {
  value = azurerm_subnet.cosmosdb_subnet.id
}
