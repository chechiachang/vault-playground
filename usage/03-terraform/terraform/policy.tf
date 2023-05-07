resource "vault_policy" "example_policy" {
  name   = "example_policy"
  policy = <<-EOF
    path "secret/data/myapp/*" {
      capabilities = ["read"]
    }
    path "secret/data/myapp/config" {
      capabilities = ["read", "list"]
    }
  EOF
}
