run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "test_app_service" {
  command = apply

  variables {
    service_plan_name       = "${run.setup_tests.test_prefix}-plan"
    app_service_name        = "${run.setup_tests.test_prefix}-app-service"
    location                = "France Central"
    resource_group_name     = "${run.setup_tests.test_prefix}-resource-group"
    docker_registry_username = "testuser"
    docker_registry_password = "testpass"
    docker_image_name       = "testimage:latest"
    api_key                 = "test-api-key"
    cosmosdb_endpoint       = "https://test-cosmosdb.documents.azure.com:443/"
    cosmosdb_database_name  = "test-db"
    cosmosdb_container_name = "test-container"
  }

  assert {
    condition     = module.app_service.service_plan_name == "${run.setup_tests.test_prefix}-plan"
    error_message = "App Service Plan name mismatch."
  }

  assert {
    condition     = module.app_service.app_service_name == "${run.setup_tests.test_prefix}-app-service"
    error_message = "App Service name mismatch."
  }

  assert {
    condition     = module.app_service.default_hostname != ""
    error_message = "App Service default hostname not created."
  }
}
