# Crée un réseau virtuel Azure pour héberger les sous-réseaux et autres ressources réseau.
resource "azurerm_virtual_network" "shop_app_vnet" {
  name                = var.vnet_name              # Nom du réseau virtuel, défini via une variable.
  location            = var.location                # Région Azure où le réseau virtuel sera déployé.
  resource_group_name = var.resource_group_name     # Groupe de ressources associé.
  address_space       = [var.vnet_address_space]    # Plage d'adresses IP pour le réseau virtuel.
}

# Crée un sous-réseau dédié à l'application web dans le réseau virtuel.
resource "azurerm_subnet" "app_service_subnet" {
  name                 = var.app_service_subnet_name  # Nom du sous-réseau pour l'application web.
  resource_group_name  = var.resource_group_name      # Groupe de ressources associé.
  virtual_network_name = azurerm_virtual_network.shop_app_vnet.name # Réseau virtuel auquel appartient ce sous-réseau.
  address_prefixes     = [var.subnet_app_service]     # Plage d'adresses IP du sous-réseau.

  # Définition de la délégation pour ce sous-réseau, permettant son utilisation par des services spécifiques.
  delegation {
    name = "webapp_delegation"  # Nom de la délégation.
    service_delegation {
      name    = "Microsoft.Web/serverFarms"           # Service autorisé à utiliser ce sous-réseau.
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"] # Actions autorisées sur ce sous-réseau.
    }
  }
}

# Crée un sous-réseau pour CosmosDB, avec des points de terminaison de service dédiés.
resource "azurerm_subnet" "cosmosdb_subnet" {
  name                 = var.cosmosdb_subnet_name  # Nom du sous-réseau pour CosmosDB.
  resource_group_name  = var.resource_group_name    # Groupe de ressources associé.
  virtual_network_name = azurerm_virtual_network.shop_app_vnet.name # Réseau virtuel auquel appartient ce sous-réseau.
  address_prefixes     = [var.subnet_cosmosdb]     # Plage d'adresses IP du sous-réseau.
  service_endpoints    = ["Microsoft.AzureCosmosDB"] # Point de terminaison de service pour CosmosDB.
}

# Crée un sous-réseau par défaut dans le réseau virtuel pour d'autres usages.
resource "azurerm_subnet" "default_subnet" {
  name                 = var.default_subnet_name        # Nom du sous-réseau par défaut.
  resource_group_name  = var.resource_group_name        # Groupe de ressources associé.
  virtual_network_name = azurerm_virtual_network.shop_app_vnet.name # Réseau virtuel auquel appartient ce sous-réseau.
  address_prefixes     = [var.default_subnet_address_prefix] # Plage d'adresses IP pour ce sous-réseau.
}
