run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "test_virtual_network" {
  command = apply

  variables {
    vnet_name                  = "${run.setup_tests.test_prefix}-vnet"
    location                   = "France Central"
    resource_group_name        = "${run.setup_tests.test_prefix}-resource-group"
    vnet_address_space         = "10.0.0.0/16"
    app_service_subnet_name    = "app-service-subnet"
    subnet_app_service         = "10.0.1.0/24"
    cosmosdb_subnet_name       = "cosmosdb-subnet"
    subnet_cosmosdb            = "10.0.2.0/24"
    default_subnet_name        = "default-subnet"
    default_subnet_address_prefix = "10.0.3.0/24"
  }

  assert {
    condition     = module.virtual_network.vnet_id != ""
    error_message = "Virtual Network ID not created."
  }

  assert {
    condition     = module.virtual_network.app_service_subnet_id != ""
    error_message = "App Service Subnet ID not created."
  }

  assert {
    condition     = module.virtual_network.cosmosdb_subnet_id != ""
    error_message = "CosmosDB Subnet ID not created."
  }
}
