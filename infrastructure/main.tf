# Configure le fournisseur Azure Resource Manager (azurerm) pour Terraform.
provider "azurerm" {
  features {}                      # Active toutes les fonctionnalités par défaut du fournisseur.
  subscription_id = var.subscription_id # Identifiant de l'abonnement Azure utilisé.
}

# Déclare les exigences de la version du fournisseur pour Terraform.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"  # Source du fournisseur Azure pour Terraform.
      version = ">= 4.11.0"          # Version minimale requise du fournisseur.
    }
  }
}

# Module pour la création du groupe de ressources.
module "resource_group" {
  source = "./modules/resource_group"  # Chemin vers le module pour le groupe de ressources.

  subscription_id     = var.subscription_id     # Identifiant de l'abonnement Azure.
  resource_group_name = var.resource_group_name # Nom du groupe de ressources.
  location            = var.location            # Région Azure pour le groupe de ressources.
}

# Module pour la création du réseau virtuel.
module "virtual_network" {
  source = "./modules/virtual_network"  # Chemin vers le module pour le réseau virtuel.

  vnet_name                    = var.vnet_name                      # Nom du réseau virtuel.
  location                     = module.resource_group.location     # Région du groupe de ressources.
  resource_group_name          = module.resource_group.name         # Nom du groupe de ressources.
  vnet_address_space           = var.vnet_address_space             # Plage d'adresses du réseau virtuel.
  app_service_subnet_name      = var.app_service_subnet_name        # Nom du sous-réseau pour l'application web.
  subnet_app_service           = var.subnet_app_service             # Plage d'adresses du sous-réseau de l'application web.
  cosmosdb_subnet_name         = var.cosmosdb_subnet_name           # Nom du sous-réseau pour CosmosDB.
  subnet_cosmosdb              = var.subnet_cosmosdb                # Plage d'adresses du sous-réseau CosmosDB.
  default_subnet_name          = var.default_subnet_name            # Nom du sous-réseau par défaut.
  default_subnet_address_prefix = var.default_subnet_address_prefix  # Plage d'adresses du sous-réseau par défaut.
}

# Module pour la création du service App Service (web app).
module "app_service" {
  source = "./modules/app_service"  # Chemin vers le module pour l'application web.

  service_plan_name       = var.service_plan_name        # Nom du plan de service pour l'application web.
  app_service_name        = var.app_service_name         # Nom du service web (App Service).
  location                = module.resource_group.location  # Région du groupe de ressources.
  resource_group_name     = module.resource_group.name    # Nom du groupe de ressources.
  docker_registry_username = var.docker_registry_username  # Nom d'utilisateur du registre Docker.
  docker_registry_password = var.docker_registry_password  # Mot de passe du registre Docker.
  docker_image_name        = var.docker_image_name        # Nom de l'image Docker pour l'application.
  app_service_subnet_id    = module.virtual_network.app_service_subnet_id  # ID du sous-réseau de l'application web.
  api_key                  = var.api_key                  # Clé API utilisée par l'application web.

  cosmosdb_endpoint       = var.cosmosdb_endpoint
  cosmosdb_readonly_key   = module.cosmosdb.cosmosdb_readonly_key
  cosmosdb_database_name  = var.cosmosdb_database_name
  cosmosdb_container_name = var.cosmosdb_container_name
}

# Module pour la création du compte CosmosDB.
module "cosmosdb" {
  source = "./modules/cosmosdb"  # Chemin vers le module pour CosmosDB.

  cosmosdb_account_name = var.cosmosdb_account_name  # Nom du compte CosmosDB.
  location              = module.resource_group.location  # Région du groupe de ressources.
  resource_group_name   = module.resource_group.name  # Nom du groupe de ressources.
  cosmosdb_subnet_id    = module.virtual_network.cosmosdb_subnet_id  # ID du sous-réseau CosmosDB.
  database_name         = var.database_name          # Nom de la base de données CosmosDB.
  container_name        = var.container_name         # Nom du conteneur CosmosDB.
  subscription_id       = var.subscription_id       # Identifiant de l'abonnement Azure.
  authorized_ips        = var.authorized_ips         # Liste des adresses IP autorisées à accéder à CosmosDB.
}
