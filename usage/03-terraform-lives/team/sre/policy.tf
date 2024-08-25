resource "vault_policy" "sre" {
  name = "sre"

  policy = <<-EOF
    path "localhost_mariadb/creds/*" {
      capabilities = ["read"]
    }
  EOF
}
