# Nom du groupe de ressources Azure.
variable "resource_group_name" {
  type = string
}

# Région Azure où les ressources seront déployées.
variable "location" {
  type = string
}

# Identifiant de l'abonnement Azure.
variable "subscription_id" {
  type = string
}
