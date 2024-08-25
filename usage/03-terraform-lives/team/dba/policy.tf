resource "vault_policy" "dba" {
  name = "dba"

  policy = <<-EOF
    path "localhost_mariadb/creds/*" {
      capabilities = ["read"]
    }
  EOF
}
