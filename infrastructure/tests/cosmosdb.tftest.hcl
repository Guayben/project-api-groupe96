run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "test_cosmosdb" {
  command = apply

  variables {
    cosmosdb_account_name = "${run.setup_tests.test_prefix}-cosmosdb"
    location              = "France Central"
    resource_group_name   = "${run.setup_tests.test_prefix}-resource-group"
    cosmosdb_subnet_id    = "test-cosmosdb-subnet-id"
    database_name         = "test-db"
    items_container_name  = "Items"
    users_container_name  = "Users"
    baskets_container_name = "Baskets"
  }

  assert {
    condition     = module.cosmosdb.cosmosdb_endpoint != ""
    error_message = "CosmosDB endpoint not created."
  }

  assert {
    condition     = module.cosmosdb.cosmosdb_database_name == "test-db"
    error_message = "CosmosDB database name mismatch."
  }

  assert {
    condition     = module.cosmosdb.cosmosdb_container_name == "Items"
    error_message = "CosmosDB Items container name mismatch."
  }
}
