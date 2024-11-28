resource "azurerm_resource_group" "shop_app_rg" {
  name     = var.resource_group_name
  location = var.location
}
