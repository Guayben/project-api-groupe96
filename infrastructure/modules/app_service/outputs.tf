# Expose la sortie contenant le nom d'hôte par défaut de l'application web.
output "default_hostname" {
  value = azurerm_linux_web_app.shop_app_service.default_hostname # Récupère et expose le nom d'hôte par défaut de l'application.
}
