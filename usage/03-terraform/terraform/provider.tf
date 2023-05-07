provider "vault" {
  #address = "http://vault.example.com:8200"
  address = var.vault_address != "" ? var.vault_address : "http://0.0.0.0:8200"

  #token   = "your_vault_token" # Don't hardcode this in production!
}
