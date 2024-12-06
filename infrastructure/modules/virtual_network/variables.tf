# Nom du réseau virtuel.
variable "vnet_name" {
  type = string
}

# Région Azure où les ressources seront déployées.
variable "location" {
  type = string
}

# Nom du groupe de ressources où les ressources seront créées.
variable "resource_group_name" {
  type = string
}

# Plage d'adresses IP pour le réseau virtuel.
variable "vnet_address_space" {
  type = string
}

# Nom du sous-réseau dédié à l'application web.
variable "app_service_subnet_name" {
  type = string
}

# Plage d'adresses IP pour le sous-réseau de l'application web.
variable "subnet_app_service" {
  type = string
}

# Nom du sous-réseau dédié à CosmosDB.
variable "cosmosdb_subnet_name" {
  type = string
}

# Plage d'adresses IP pour le sous-réseau de CosmosDB.
variable "subnet_cosmosdb" {
  type = string
}

# Nom du sous-réseau par défaut.
variable "default_subnet_name" {
  type = string
}

# Plage d'adresses IP pour le sous-réseau par défaut.
variable "default_subnet_address_prefix" {
  type = string
}
