Ce projet a été réalisé par Lancelot Gambier, Guillaume Cazier, Antoine Chanteloup et Clément Calujek

# Déploiement d'une Infrastructure Azure avec Terraform

Ce projet déploie une infrastructure Azure comprenant un groupe de ressources, un réseau virtuel, un service App Service, et une base de données CosmosDB, le tout configuré avec Terraform. Il inclut également une API Flask déployée sur App Service. Cette documentation explique comment lancer et tester l'ensemble du projet.

---

## Prérequis

Avant de commencer, vous devez installer les outils suivants sur votre machine :
1. **Terraform** : [Guide d'installation officiel](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
2. **Azure CLI** : [Guide d'installation officiel](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
3. **Docker**  : [Installer Docker](https://docs.docker.com/get-docker/).

---

## Structure du Projet

```
.
├── .github
│   └── workflows
│       ├── deploy.yml
│       └── pull_request.yml
├── api
│   ├── templates
│   │   └── index.html
│   ├── tests
│   │   ├── __init__.py
│   │   └── test_app.py
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── infrastructure
│   ├── modules
│   │   ├── app_service
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── cosmosdb
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── resource_group
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── virtual_network
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── tests
│   │   └── terraform_test_code.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── terraform.lock.hcl
│   ├── terraform.tfstate
│   ├── terraform.tfvars
│   └── variables.tf
├── .gitignore
└── README.md
```

---

## Étapes de Déploiement

### 1. Cloner le dépôt
Commencez par cloner ce dépôt sur votre machine locale :
```bash
git clone https://github.com/votre-repo/infra-terraform.git
cd infra-terraform
```

---

### 2. Configurer Azure CLI
Connectez-vous à Azure avec la commande suivante :
```bash
az login
```
Cela ouvrira une fenêtre de navigateur pour authentifier votre compte Azure.

Ensuite, sélectionnez l'abonnement Azure à utiliser :
```bash
az account set --subscription "<ID_DE_VOTRE_ABONNEMENT>"
```

---

### 3. Initialiser Terraform
Initialisez le projet Terraform pour télécharger les plugins nécessaires :
```bash
cd infrastructure
terraform init
```

---

### 4. Configurer les Variables
Toutes les variables nécessaires sont définies dans le fichier `terraform.tfvars`, qui est **ignoré par Git** pour éviter de compromettre vos secrets. Créez ce fichier manuellement si ce n'est pas déjà fait.

Voici un exemple de contenu pour `terraform.tfvars` :
```hcl
docker_registry_username = "votre_nom_utilisateur_docker"
docker_registry_password = "votre_mot_de_passe_docker"
subscription_id          = "votre_id_abonnement_azure"
api_key                  = "votre_clé_api"
cosmosdb_endpoint        = "https://votre-compte-cosmosdb.documents.azure.com:443/"
```

⚠️ **Important** : 
- Ne partagez jamais ce fichier avec d'autres personnes.
- Utilisez un gestionnaire de secrets comme Azure Key Vault pour plus de sécurité.

---

### 5. Vérifier et Appliquer la Configuration Terraform
Vérifiez la configuration :
```bash
terraform validate
```

Générez un plan d'exécution pour vérifier les modifications qui seront effectuées :
```bash
terraform plan
```

Appliquez la configuration pour déployer les ressources :
```bash
terraform apply
```

Vous devrez confirmer l'exécution en tapant `yes` lorsque Terraform vous le demandera.

---

### 6. Récupérer les Informations Déployées
Une fois le déploiement terminé, Terraform affichera les sorties définies dans `outputs.tf`. Ces sorties incluent des informations utiles comme :
- L'URL de votre App Service (`app_service_url`).
- L'endpoint CosmosDB (`cosmosdb_endpoint`).

Vous pouvez également afficher ces informations à tout moment avec :
```bash
terraform output
```

---

### 7. Tester les Modules Terraform
Pour tester les modules Terraform, exécutez la commande suivante dans le dossier `infrastructure` :
```bash
cd tests
terraform test
```

---

### 8. Gestion des Secrets pour GitHub Actions

Pour exécuter les workflows CI/CD dans GitHub Actions, vous devez configurer les **secrets GitHub** suivants :
- `AZURE_SUBSCRIPTION_ID` : ID de l'abonnement Azure utilisé.
- `AZURE_WEBAPP_PUBLISH_PROFILE` : Profil de publication de l'App Service Azure.
- `DOCKER_USERNAME` : Nom d'utilisateur Docker Hub.
- `DOCKER_PASSWORD` : Mot de passe Docker Hub.

---

### ⚠️ Attention : Gestion Manuelle des Credentials Azure
Les comptes étudiants de **JUNIA** ne permettent pas d'accéder directement aux credentials Azure via le CLI. Cela implique que :
1. Si de nouvelles ressources (comme un App Service) sont créées avec `terraform apply`, vous devrez récupérer manuellement le **publish profile** depuis le portail Azure.
2. Une fois récupéré, ajoutez le publish profile dans les secrets GitHub (`AZURE_WEBAPP_PUBLISH_PROFILE`).

---

## Nettoyage des Ressources
Pour supprimer toutes les ressources créées par Terraform, exécutez la commande suivante :
```bash
terraform destroy
```

---

## Tester l'API Flask

### 1. Installation des Dépendances
Dans le dossier `api`, installez les dépendances Python :
```bash
pip install -r requirements.txt
```

### 2. Lancer l'API Localement
Exécutez l'application Flask en local :
```bash
python app.py
```

### 3. Exécuter les Tests Unitaires
Lancez les tests pour vérifier que l'API fonctionne correctement :
```bash
pytest tests
```

---
