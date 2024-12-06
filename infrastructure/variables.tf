variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "France Central"
}

variable "resource_group_name" {
  type    = string
  default = "API-shop-app-cc-junia"
}

variable "vnet_name" {
  type    = string
  default = "shop-app-vnet"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "app_service_subnet_name" {
  type    = string
  default = "app-service-subnet"
}

variable "subnet_app_service" {
  type    = string
  default = "10.0.1.0/24"
}

variable "cosmosdb_subnet_name" {
  type    = string
  default = "cosmosdb-subnet"
}

variable "subnet_cosmosdb" {
  type    = string
  default = "10.0.2.0/24"
}

variable "default_subnet_name" {
  type    = string
  default = "default-subnet"
}

variable "default_subnet_address_prefix" {
  type    = string
  default = "10.0.3.0/24"
}

variable "service_plan_name" {
  type    = string
  default = "shop-app-plan"
}

variable "app_service_name" {
  type    = string
  default = "shop-app-service-cc-clemclem"
}

variable "docker_registry_username" {
  type = string
}

variable "docker_registry_password" {
  type = string
}

variable "docker_image_name" {
  type    = string
  default = "guayben/shop-app:latest"
}

variable "api_key" {
  type = string
}

variable "cosmosdb_account_name" {
  type    = string
  default = "shop-app-cosmosdb"
}

variable "database_name" {
  type    = string
  default = "shop-app-db"
}

variable "container_name" {
  type    = string
  default = "shop-app-container"
}

variable "cosmosdb_endpoint" {
  description = "Endpoint of the Cosmos DB"
  type        = string
}

variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB database"
  type        = string
}

variable "cosmosdb_container_name" {
  description = "Name of the Cosmos DB container"
  type        = string
}
