# Configure the database secrets engine and create roles
path "database/creds/readonly" {
  capabilities = ["read"]
}
