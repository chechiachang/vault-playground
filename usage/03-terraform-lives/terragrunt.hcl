terraform {
  source = "../..//usage/03-terraform-lives/terraform"

  extra_arguments "policy" {
    commands = ["apply"]
  }
}

inputs = {
  vault_address = "http://0.0.0.0:8200"
}
