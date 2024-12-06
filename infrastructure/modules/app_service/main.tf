# Déclare un App Service Plan dans Azure, qui fournit les ressources nécessaires pour exécuter des applications web.
resource "azurerm_service_plan" "shop_app_plan" {
  name                = var.service_plan_name  # Nom du plan, défini via une variable.
  location            = var.location           # Région Azure pour déployer ce service.
  resource_group_name = var.resource_group_name # Groupe de ressources associé.
  os_type             = "Linux"                # Système d'exploitation pour l'application (Linux).
  sku_name            = "B1"                   # Niveau de tarification et capacité (niveau "B1", basique).
}

# Configure une application web basée sur Linux, utilisant le plan défini précédemment.
resource "azurerm_linux_web_app" "shop_app_service" {
  depends_on          = [azurerm_service_plan.shop_app_plan] # Dépend du plan de service défini ci-dessus.
  name                = var.app_service_name                # Nom de l'application web, défini via une variable.
  location            = var.location                        # Région Azure pour déployer l'application.
  resource_group_name = var.resource_group_name             # Groupe de ressources associé.
  service_plan_id     = azurerm_service_plan.shop_app_plan.id # Identifiant du plan de service associé.
  https_only          = true                                # Force l'utilisation de HTTPS uniquement pour l'accès.

  # Configuration des paramètres du site web.
  site_config {
    always_on = true                                       # Permet de maintenir l'application en ligne en permanence.
    application_stack {
      docker_registry_url      = "https://index.docker.io/v1/" # URL du registre Docker.
      docker_registry_username = var.docker_registry_username # Identifiant du registre Docker (variable).
      docker_registry_password = var.docker_registry_password # Mot de passe du registre Docker (variable).
      docker_image_name        = var.docker_image_name        # Nom de l'image Docker à utiliser (variable).
    }
  }

  virtual_network_subnet_id = var.app_service_subnet_id # ID du sous-réseau virtuel pour l'application web.

  # Paramètres d'application définissant les variables d'environnement pour l'application.
  app_settings = {
    API_KEY = var.api_key
    COSMOSDB_ENDPOINT       = var.cosmosdb_endpoint
    COSMOSDB_READONLY_KEY   = var.cosmosdb_readonly_key
    COSMOSDB_DATABASE_NAME  = var.cosmosdb_database_name
    COSMOSDB_CONTAINER_NAME = var.cosmosdb_container_name
  }

  client_affinity_enabled = false # Désactive l'affinité client pour les sessions persistantes.
}
