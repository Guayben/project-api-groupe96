resource "azurerm_virtual_network" "shop_app_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "app_service_subnet" {
  name                 = var.app_service_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shop_app_vnet.name
  address_prefixes     = [var.subnet_app_service]
  
  delegation {
    name = "webapp_delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "cosmosdb_subnet" {
  name                 = var.cosmosdb_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shop_app_vnet.name
  address_prefixes     = [var.subnet_cosmosdb]
  service_endpoints    = ["Microsoft.AzureCosmosDB"]
}

resource "azurerm_subnet" "default_subnet" {
  name                 = var.default_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.shop_app_vnet.name
  address_prefixes     = [var.default_subnet_address_prefix]
}
