# Expose la sortie contenant le nom d'hôte par défaut de l'application web.
output "default_hostname" {
  value = azurerm_linux_web_app.shop_app_service.default_hostname # Récupère et expose le nom d'hôte par défaut de l'application.
}

output "service_plan_name" {
  value = azurerm_service_plan.shop_app_plan.name
}

output "app_service_name" {
  value = azurerm_linux_web_app.shop_app_service.name
}