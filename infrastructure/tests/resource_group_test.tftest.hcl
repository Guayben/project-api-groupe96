run "setup_provider" {
  module {
    source = "./tests/setup"
  }

  # Pas besoin de spécifier subscription_id ici, il sera pris depuis test.tfvars
}

run "create_resource_group" {
  module {
    source = "./modules/resource_group"
  }

  variables {
    resource_group_name = "test-rg"
    location            = "France Central"
    subscription_id     = var.subscription_id
  }
}
