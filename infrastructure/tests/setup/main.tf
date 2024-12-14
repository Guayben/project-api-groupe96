terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_pet" "test_prefix" {
  length = 3
}

output "test_prefix" {
  value = random_pet.test_prefix.id
}
