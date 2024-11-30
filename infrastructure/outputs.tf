output "app_service_url" {
  value = module.app_service.default_hostname
}

output "cosmosdb_endpoint" {
  value = module.cosmosdb.cosmosdb_endpoint
}

output "cosmosdb_readonly_key" {
  value     = module.cosmosdb.cosmosdb_readonly_key
  sensitive = true
}

output "cosmosdb_database_name" {
  value = module.cosmosdb.cosmosdb_database_name
}

output "cosmosdb_container_name" {
  value = module.cosmosdb.cosmosdb_container_name
}

