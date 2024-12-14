run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "test_resource_group" {
  command = apply

  variables {
    resource_group_name = "${run.setup_tests.test_prefix}-resource-group"
    location            = "France Central"
    subscription_id     = "79f11903-d0db-47a2-acc8-ce9d9d3fa470"
  }

  assert {
    condition     = module.resource_group.name == "${run.setup_tests.test_prefix}-resource-group"
    error_message = "Resource Group name mismatch."
  }

  assert {
    condition     = module.resource_group.location == "francecentral"
    error_message = "Resource Group location mismatch."
  }
}
