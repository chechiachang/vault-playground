resource "vault_policy" "main" {
  name = "database_write_${var.name}"

  policy = <<-EOF
    path "${var.path}/creds/database_write" {
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
