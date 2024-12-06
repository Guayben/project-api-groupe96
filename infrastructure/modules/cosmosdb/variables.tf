# Nom du compte CosmosDB.
variable "cosmosdb_account_name" {
  type = string
}

# Région Azure où le compte CosmosDB sera déployé.
variable "location" {
  type = string
}

# Groupe de ressources dans lequel le compte CosmosDB sera créé.
variable "resource_group_name" {
  type = string
}

# ID du sous-réseau virtuel pour le compte CosmosDB.
variable "cosmosdb_subnet_id" {
  type = string
}

# Nom de la base de données dans le compte CosmosDB.
variable "database_name" {
  type = string
}

# Nom du conteneur dans la base de données CosmosDB.
variable "items_container_name" {
  type = string
}

variable "users_container_name" {
  type = string
}

variable "baskets_container_name" {
  type = string
}

# Identifiant de l'abonnement Azure, non typé explicitement.
variable "subscription_id" {}
