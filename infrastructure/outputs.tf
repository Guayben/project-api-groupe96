# Expose l'URL de l'App Service (web app) créée par le module app_service.
output "app_service_url" {
  value = module.app_service.default_hostname  # URL de l'App Service.
}

# Expose le point de terminaison de CosmosDB pour une utilisation ultérieure.
output "cosmosdb_endpoint" {
  value = module.cosmosdb.cosmosdb_endpoint  # Point de terminaison de CosmosDB.
}

# Expose la clé de lecture seule de CosmosDB de manière sensible.
output "cosmosdb_readonly_key" {
  value     = module.cosmosdb.cosmosdb_readonly_key  # Clé de lecture seule pour CosmosDB.
  sensitive = true  # Marque la valeur comme sensible pour éviter d'afficher dans les logs.
}

# Expose le nom de la base de données CosmosDB créée par le module cosmosdb.
output "cosmosdb_database_name" {
  value = module.cosmosdb.cosmosdb_database_name  # Nom de la base de données CosmosDB.
}

# Expose le nom du conteneur CosmosDB créé par le module cosmosdb.
output "cosmosdb_container_name" {
  value = module.cosmosdb.cosmosdb_container_name  # Nom du conteneur CosmosDB.
}
