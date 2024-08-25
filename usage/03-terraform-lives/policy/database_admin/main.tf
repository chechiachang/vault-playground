resource "vault_policy" "main" {
  name = "database_admin"

  policy = <<-EOF
    path "${var.path}/database" {
      capabilities = ["create", "read", "update", "patch", "delete", "list"]
    }
  EOF
}

variable "path" {
  type = string
}
