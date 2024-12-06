# Expose le nom du groupe de ressources Azure pour qu'il puisse être utilisé ailleurs.
output "name" {
  value = azurerm_resource_group.shop_app_rg.name # Nom du groupe de ressources.
}

# Expose la région (emplacement) du groupe de ressources Azure pour qu'elle puisse être utilisée ailleurs.
output "location" {
  value = azurerm_resource_group.shop_app_rg.location # Région du groupe de ressources.
}
