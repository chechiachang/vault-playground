resource "vault_policy" "microservice" {
  name = "microservice"

  policy = <<-EOF
    path "localhost_mariadb/creds/database_write" {
      capabilities = ["read"]
    }
  EOF
}
