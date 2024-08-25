resource "vault_policy" "main" {
  name = "database_readonly_${var.name}"

  policy = <<-EOF
    path "${var.path}/creds/database_readonly" {
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
