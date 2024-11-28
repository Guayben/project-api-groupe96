variable "vnet_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_address_space" {
  type = string
}

variable "app_service_subnet_name" {
  type = string
}

variable "subnet_app_service" {
  type = string
}

variable "cosmosdb_subnet_name" {
  type = string
}

variable "subnet_cosmosdb" {
  type = string
}

variable "default_subnet_name" {
  type = string
}

variable "default_subnet_address_prefix" {
  type = string
}
