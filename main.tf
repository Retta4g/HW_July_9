terraform {
  cloud {
    organization = "02-spring-cloud"

    workspaces {
      name = "Terraform_backend"
    }
  }
  required_providers {
    tfe = {
      version = "~> 0.56.0"
    }
  }
}

provider "tfe" {}

data "tfe_organization" "foo" {
  name = "02-spring-cloud"
}

locals {
  personal_workspace = [
    "apple",
    "orange",
    "banana",
    "strawberry",
    "pineapple",
    "mango",
    "peach",
    "kiwi",
    "watermelon",
  ]
}

resource "tfe_workspace" "personal_workspace" {
  for_each = toset(local.personal_workspace)
  name     = "${each.key}_workspace_created_by_terraform"
  organization = data.tfe_organization.foo.name
}
