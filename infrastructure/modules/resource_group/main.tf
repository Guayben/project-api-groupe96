# Configure le fournisseur Azure Resource Manager (azurerm) pour Terraform.
provider "azurerm" {
  features {}                      # Active toutes les fonctionnalités par défaut du fournisseur.
  subscription_id = var.subscription_id # Identifiant de l'abonnement Azure utilisé.
}

# Crée un groupe de ressources Azure pour organiser les ressources associées à l'application.
resource "azurerm_resource_group" "shop_app_rg" {
  name     = var.resource_group_name # Nom du groupe de ressources, défini via une variable.
  location = var.location            # Région Azure pour le déploiement.
}
