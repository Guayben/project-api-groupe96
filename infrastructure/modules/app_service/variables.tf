variable "service_plan_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "docker_registry_username" {
  type = string
}

variable "docker_registry_password" {
  type = string
}

variable "docker_image_name" {
  type = string
}

variable "app_service_subnet_id" {
  type = string
}

variable "api_key" {
  type = string
}

variable "cosmosdb_endpoint" {
  description = "Endpoint of the Cosmos DB"
  type        = string
}

variable "cosmosdb_readonly_key" {
  description = "Read-only key for the Cosmos DB"
  type        = string
  sensitive   = true
}

variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB database"
  type        = string
}

variable "cosmosdb_container_name" {
  description = "Name of the Cosmos DB container"
  type        = string
}
