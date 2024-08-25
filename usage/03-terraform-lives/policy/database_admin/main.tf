resource "vault_policy" "main" {
  name = "database_admin_${var.name}"

  policy = <<-EOF
    path "${var.path}/creds/database_admin" {
      capabilities = ["read"]
    }
  EOF
}

variable "path" {
  type = string
}

variable "name" {
  type = string
}
