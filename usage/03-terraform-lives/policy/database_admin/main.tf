resource "vault_policy" "main" {
  name   = "database_admine"

  policy = <<-EOF
    path "${var.path}/database" {
      capabilities = ["read", "list"]
    }
  EOF
}

variable "path" {
  type = string
}
