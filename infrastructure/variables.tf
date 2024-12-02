# Identifiant de l'abonnement Azure.
variable "subscription_id" {
  type = string
}

# Région par défaut pour les ressources Azure (France Central).
variable "location" {
  type    = string
  default = "France Central"  # Valeur par défaut pour la région.
}

# Nom par défaut du groupe de ressources.
variable "resource_group_name" {
  type    = string
  default = "API-shop-app-cc-junia"  # Valeur par défaut pour le groupe de ressources.
}

# Nom par défaut du réseau virtuel (VNet).
variable "vnet_name" {
  type    = string
  default = "shop-app-vnet"  # Valeur par défaut pour le nom du réseau virtuel.
}

# Plage d'adresses IP par défaut pour le réseau virtuel (VNet).
variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"  # Valeur par défaut pour l'adresse du réseau virtuel.
}

# Nom par défaut du sous-réseau destiné à l'application web (App Service).
variable "app_service_subnet_name" {
  type    = string
  default = "app-service-subnet"  # Valeur par défaut pour le nom du sous-réseau.
}

# Plage d'adresses IP par défaut pour le sous-réseau de l'application web.
variable "subnet_app_service" {
  type    = string
  default = "10.0.1.0/24"  # Valeur par défaut pour la plage d'adresses du sous-réseau.
}

# Nom par défaut du sous-réseau destiné à CosmosDB.
variable "cosmosdb_subnet_name" {
  type    = string
  default = "cosmosdb-subnet"  # Valeur par défaut pour le nom du sous-réseau CosmosDB.
}

# Plage d'adresses IP par défaut pour le sous-réseau CosmosDB.
variable "subnet_cosmosdb" {
  type    = string
  default = "10.0.2.0/24"  # Valeur par défaut pour la plage d'adresses du sous-réseau CosmosDB.
}

# Nom par défaut du sous-réseau par défaut.
variable "default_subnet_name" {
  type    = string
  default = "default-subnet"  # Valeur par défaut pour le nom du sous-réseau par défaut.
}

# Plage d'adresses IP par défaut pour le sous-réseau par défaut.
variable "default_subnet_address_prefix" {
  type    = string
  default = "10.0.3.0/24"  # Valeur par défaut pour la plage d'adresses du sous-réseau par défaut.
}

# Nom par défaut du plan de service pour l'application web.
variable "service_plan_name" {
  type    = string
  default = "shop-app-plan"  # Valeur par défaut pour le nom du plan de service.
}

# Nom par défaut du service web (App Service).
variable "app_service_name" {
  type    = string
  default = "shop-app-service-cc-clemclem"  # Valeur par défaut pour le nom du service web.
}

# Nom d'utilisateur du registre Docker (non défini par défaut).
variable "docker_registry_username" {
  type = string
}

# Mot de passe du registre Docker (non défini par défaut).
variable "docker_registry_password" {
  type = string
}

# Nom de l'image Docker par défaut pour l'application web.
variable "docker_image_name" {
  type    = string
  default = "guayben/shop-app:latest"  # Valeur par défaut pour le nom de l'image Docker.
}

# Clé API pour l'application web (non définie par défaut).
variable "api_key" {
  type = string
}

# Nom par défaut du compte CosmosDB.
variable "cosmosdb_account_name" {
  type    = string
  default = "shop-app-cosmosdb"  # Valeur par défaut pour le nom du compte CosmosDB.
}

# Nom par défaut de la base de données CosmosDB.
variable "database_name" {
  type    = string
  default = "shop-app-db"  # Valeur par défaut pour le nom de la base de données.
}

# Nom par défaut du conteneur CosmosDB.
variable "container_name" {
  type    = string
  default = "shop-app-container"  # Valeur par défaut pour le nom du conteneur CosmosDB.
}

# Point de terminaison de CosmosDB (non défini par défaut).
variable "cosmosdb_endpoint" {
  description = "Endpoint of the Cosmos DB"  # Description du point de terminaison.
  type        = string
}

# Clé de lecture seule de CosmosDB (non définie par défaut).
variable "cosmosdb_readonly_key" {
  description = "Read-only key for the Cosmos DB"  # Description de la clé de lecture seule.
  type        = string
  sensitive   = true  # Marque cette variable comme sensible (ne doit pas être affichée dans les logs).
}

# Nom de la base de données CosmosDB (non défini par défaut).
variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB database"  # Description du nom de la base de données.
  type        = string
}

# Nom du conteneur CosmosDB (non défini par défaut).
variable "cosmosdb_container_name" {
  description = "Name of the Cosmos DB container"  # Description du nom du conteneur.
  type        = string
}

# Liste des IPs autorisées à accéder à CosmosDB.
variable "authorized_ips" {
  description = "List of IPs allowed to access Cosmos DB."  # Description de la liste des IPs autorisées.
  type        = list(string)
  default     = ["203.0.113.0", "198.51.100.0"]  # Valeur par défaut pour les IPs autorisées.
}
