resource "vault_policy" "backend" {
  name = "backend"

  policy = <<-EOF
    path "localhost_mariadb/creds/database_read" {
      capabilities = ["read"]
    }
  EOF
}
