resource "vault_policy" "main" {
  name   = "database_write"

  policy = <<-EOF
    path "${var.path}/database" {
      capabilities = ["create", "read", "update", "patch", "delete", "list"]
    }
  EOF
}

variable "path" {
  type = string
}
