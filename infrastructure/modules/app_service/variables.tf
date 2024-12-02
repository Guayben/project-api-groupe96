# Nom du service plan Azure utilisé pour héberger les applications.
variable "service_plan_name" {
  type = string 
}

# Nom de l'application web à déployer.
variable "app_service_name" {
  type = string 
}

# Région Azure où les ressources seront déployées.
variable "location" {
  type = string 
}

# Groupe de ressources Azure dans lequel les ressources seront créées.
variable "resource_group_name" {
  type = string 
}

# Identifiant utilisateur pour le registre Docker.
variable "docker_registry_username" {
  type = string 
}

# Mot de passe pour l'authentification au registre Docker.
variable "docker_registry_password" {
  type = string 
}

# Nom de l'image Docker à utiliser pour l'application.
variable "docker_image_name" {
  type = string 
}

# ID du sous-réseau dans lequel l'application sera connectée.
variable "app_service_subnet_id" {
  type = string 
}

# Clé API utilisée par l'application.
variable "api_key" {
  type = string 
}

# Endpoint de la base de données CosmosDB.
variable "cosmosdb_endpoint" {
  description = "Endpoint of the Cosmos DB" 
  type        = string                     
}

# Clé de lecture seule pour accéder à CosmosDB.
variable "cosmosdb_readonly_key" {
  description = "Read-only key for the Cosmos DB" 
  type        = string                           
  sensitive   = true                              # Marque la variable comme sensible pour éviter qu'elle ne soit exposée.
}

# Nom de la base de données CosmosDB.
variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB database" 
  type        = string                           
}

# Nom du conteneur dans la base de données CosmosDB.
variable "cosmosdb_container_name" {
  description = "Name of the Cosmos DB container" 
  type        = string                            
}
