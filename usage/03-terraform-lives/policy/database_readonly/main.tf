resource "vault_policy" "main" {
  name   = "database_readonly"

  policy = <<-EOF
    path "${var.path}/database" {
      capabilities = ["read", "list"]
    }
  EOF
}

variable "path" {
  type = string
}
