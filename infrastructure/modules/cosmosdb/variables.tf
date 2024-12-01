variable "cosmosdb_account_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "cosmosdb_subnet_id" {
  type = string
}

variable "database_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "subscription_id" {}

variable "authorized_ips" {
  description = "List of IPs allowed to access Cosmos DB."
  type        = list(string)
}