# https://developer.hashicorp.com/terraform/language/modules/testing-experiment#writing-tests-for-a-module
terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

module "main" {
  source = "../.."

  mount_path  = local.mount_path
  description = local.description
}

locals {
  mount_path           = "test-mount"
  description          = "test-description"
  max_versions         = module.main.max_versions
  delete_version_after = module.main.delete_version_after
}

resource "test_assertions" "main" {
  component = "main"
  equal "mount_path" {
    description = "default mount_path is ${local.mount_path}"
    got         = local.mount_path
    want        = local.mount_path
  }

  equal "max_versions" {
    description = "default max_versions is 10"
    got         = local.max_versions
    want        = 10
  }

  equal "delete_version_after" {
    description = "default delete_version_after is 10"
    got         = local.delete_version_after
    want        = 12600
  }
}
