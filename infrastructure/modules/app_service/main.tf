resource "azurerm_service_plan" "shop_app_plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "shop_app_service" {
  depends_on          = [azurerm_service_plan.shop_app_plan]
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.shop_app_plan.id
  https_only          = true

  site_config {
    always_on = true
    application_stack {
      docker_registry_url      = "https://index.docker.io/v1/"
      docker_registry_username = var.docker_registry_username
      docker_registry_password = var.docker_registry_password
      docker_image_name        = var.docker_image_name
    }
  }

  virtual_network_subnet_id = var.app_service_subnet_id

  app_settings = {
    API_KEY = var.api_key
  }

  client_affinity_enabled = false
}
