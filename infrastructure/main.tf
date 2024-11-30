provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.11.0"
    }
  }
}

module "resource_group" {
  source = "./modules/resource_group"

  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source = "./modules/virtual_network"

  vnet_name                    = var.vnet_name
  location                     = module.resource_group.location
  resource_group_name          = module.resource_group.name
  vnet_address_space           = var.vnet_address_space
  app_service_subnet_name      = var.app_service_subnet_name
  subnet_app_service           = var.subnet_app_service
  cosmosdb_subnet_name         = var.cosmosdb_subnet_name
  subnet_cosmosdb              = var.subnet_cosmosdb
  default_subnet_name          = var.default_subnet_name
  default_subnet_address_prefix = var.default_subnet_address_prefix
}

module "app_service" {
  source = "./modules/app_service"

  service_plan_name       = var.service_plan_name
  app_service_name        = var.app_service_name
  location                = module.resource_group.location
  resource_group_name     = module.resource_group.name
  docker_registry_username = var.docker_registry_username
  docker_registry_password = var.docker_registry_password
  docker_image_name        = var.docker_image_name
  app_service_subnet_id    = module.virtual_network.app_service_subnet_id
  api_key                  = var.api_key

  cosmosdb_endpoint       = var.cosmosdb_endpoint
  cosmosdb_readonly_key   = var.cosmosdb_readonly_key
  cosmosdb_database_name  = var.cosmosdb_database_name
  cosmosdb_container_name = var.cosmosdb_container_name
}

module "cosmosdb" {
  source = "./modules/cosmosdb"

  cosmosdb_account_name = var.cosmosdb_account_name
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  cosmosdb_subnet_id    = module.virtual_network.cosmosdb_subnet_id
  database_name         = var.database_name
  container_name        = var.container_name
  subscription_id       = var.subscription_id
}
