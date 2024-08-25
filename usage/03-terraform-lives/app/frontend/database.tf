resource "vault_policy" "frontend" {
  name = "frontend"

  policy = <<-EOF
    path "localhost_mariadb/creds/database_readonly" {
      capabilities = ["read"]
    }
  EOF
}
