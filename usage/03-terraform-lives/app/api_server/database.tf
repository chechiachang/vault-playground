resource "vault_policy" "api_server" {
  name = "api_server"

  policy = <<-EOF
    path "locahost_mariadb/creds/database_write" {
      capabilities = ["read"]
    }
  EOF
}
