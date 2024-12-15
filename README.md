Ce projet a été réalisé par Lancelot Gambier, Guillaume Cazier, Antoine Chanteloup et Clément Calujek

# Déploiement d'une Infrastructure Azure avec Terraform

Ce projet déploie une infrastructure Azure comprenant un groupe de ressources, un réseau virtuel, un service App Service, et une base de données CosmosDB, le tout configuré avec Terraform. Il inclut également une API Flask déployée sur App Service. Cette documentation explique comment lancer et tester l'ensemble du projet.

---

## Prérequis

Avant de commencer, vous devez installer les outils suivants sur votre machine :
1. **Terraform** : [Guide d'installation officiel](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
2. **Azure CLI** : [Guide d'installation officiel](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
3. **Docker** : [Installer Docker](https://docs.docker.com/get-docker/).

---

## Configuration des Variables pour Terraform

Toutes les variables nécessaires sont définies dans un fichier `terraform.tfvars`, qui est **ignoré par Git** pour éviter de compromettre vos secrets.

### Variables Obligatoires
Voici un exemple de contenu pour `terraform.tfvars` :
```hcl
docker_registry_username = "votre_nom_utilisateur_docker"
docker_registry_password = "votre_mot_de_passe_docker"
subscription_id          = "votre_id_abonnement_azure"
api_key                  = "votre_clé_api" # n'a pas d'influence sur le fonctionnement de l'API
cosmosdb_endpoint        = "https://votre-compte-cosmosdb.documents.azure.com:443/"

# Variables pour éviter les conflits de noms
resource_group_name      = "shop-app-rg-unique"
vnet_name                = "shop-app-vnet-unique"
app_service_name         = "shop-app-service-unique"
cosmosdb_account_name    = "shop-app-cosmosdb-unique"
```

### Pourquoi ces variables sont-elles importantes ?
Si une autre infrastructure avec les mêmes noms existe déjà, Terraform échouera à déployer les ressources. Les conflits se produisent principalement sur :
- **Nom du groupe de ressources**
- **Nom du réseau virtuel (VNet)**
- **Nom du service App Service**
- **Nom du compte CosmosDB**

---

## Étapes de Déploiement

### 1. Cloner le dépôt
```bash
git clone https://github.com/Guayben/project-api-groupe96.git
cd infra-terraform
```

---

### 2. Configurer Azure CLI
Connectez-vous à Azure :
```bash
az login
```
Sélectionnez l'abonnement :
```bash
az account set --subscription "<ID_DE_VOTRE_ABONNEMENT>"
```

---

### 3. Initialiser Terraform
```bash
cd infrastructure
terraform init
```

---

### 4. Vérifier et Appliquer la Configuration
- **Valider la configuration :**
    ```bash
    terraform validate
    ```
- **Afficher le plan :**
    ```bash
    terraform plan
    ```
- **Appliquer les changements :**
    ```bash
    terraform apply
    ```

---

### 5. Tester les Modules Terraform
Dans le dossier `infrastructure`, exécutez :
```bash
cd tests
terraform test
```

---

## CI/CD avec GitHub Actions

Pour activer le déploiement continu avec GitHub Actions, configurez les **secrets GitHub** suivants :
- `AZURE_SUBSCRIPTION_ID` : ID de l'abonnement Azure.
- `AZURE_WEBAPP_PUBLISH_PROFILE` : Profil de publication pour l'App Service.
- `DOCKER_USERNAME` et `DOCKER_PASSWORD` : Identifiants Docker Hub.

⚠️ **Attention** : 
- Les comptes étudiants JUNIA ne permettent pas l'accès direct aux credentials Azure. Vous devrez récupérer manuellement le **publish profile** depuis le portail Azure après chaque `terraform apply` et le mettre à jour dans les secrets GitHub.

---


## Nettoyage des Ressources
Pour supprimer les ressources :
```bash
cd infrastructure
terraform destroy
```
