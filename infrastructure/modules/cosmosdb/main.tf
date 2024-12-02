# Crée un compte Azure CosmosDB pour stocker des données, configuré avec des règles de réseau et des politiques de cohérence.
resource "azurerm_cosmosdb_account" "shop_app_cosmosdb" {
  name                             = var.cosmosdb_account_name         # Nom du compte CosmosDB, défini via une variable.
  location                         = var.location                      # Région Azure pour déployer le compte.
  resource_group_name              = var.resource_group_name           # Groupe de ressources associé.
  offer_type                       = "Standard"                        # Offre standard pour le service.
  kind                             = "GlobalDocumentDB"                # Type de base de données (base de documents globale).
  is_virtual_network_filter_enabled = true                             # Active le filtrage des réseaux virtuels.
  public_network_access_enabled     = true                             # Permet l'accès au réseau public.

  # Politique de cohérence du compte CosmosDB.
  consistency_policy {
    consistency_level       = "Session"        # Niveau de cohérence (Session) pour équilibrer performances et disponibilité.
    max_interval_in_seconds = 5                # Délai maximal avant une synchronisation.
    max_staleness_prefix    = 100              # Nombre maximal d'opérations obsolètes tolérées.
  }

  # Emplacement géographique principal pour le compte CosmosDB.
  geo_location {
    location          = var.location           # Région principale pour les données.
    failover_priority = 0                      # Priorité pour le basculement (0 = région principale).
  }

  # Règle pour limiter l'accès à un sous-réseau virtuel spécifique.
  virtual_network_rule {
    id = var.cosmosdb_subnet_id                # Identifiant du sous-réseau autorisé.
  }

  ip_range_filter = var.authorized_ips         # Liste des adresses IP autorisées à accéder au compte.
}

# Crée une base de données SQL dans le compte CosmosDB.
resource "azurerm_cosmosdb_sql_database" "shop_app_db" {
  name                = var.database_name                       # Nom de la base de données, défini via une variable.
  resource_group_name = var.resource_group_name                 # Groupe de ressources associé.
  account_name        = azurerm_cosmosdb_account.shop_app_cosmosdb.name # Nom du compte CosmosDB parent.
}

# Crée un conteneur SQL dans la base de données CosmosDB.
resource "azurerm_cosmosdb_sql_container" "shop_app_container" {
  name                = var.container_name                       # Nom du conteneur, défini via une variable.
  resource_group_name = var.resource_group_name                  # Groupe de ressources associé.
  account_name        = azurerm_cosmosdb_account.shop_app_cosmosdb.name # Nom du compte CosmosDB parent.
  database_name       = azurerm_cosmosdb_sql_database.shop_app_db.name # Nom de la base de données parent.
  partition_key_paths = ["/partitionKey"]                        # Chemin de la clé de partition.
  throughput          = 400                                      # Débit provisionné pour le conteneur (en RU/s).
}

# Accède aux informations du compte CosmosDB, comme les clés ou l'URL.
data "azurerm_cosmosdb_account" "shop_app_keys" {
  name                = azurerm_cosmosdb_account.shop_app_cosmosdb.name # Nom du compte CosmosDB.
  resource_group_name = var.resource_group_name                         # Groupe de ressources associé.
}
