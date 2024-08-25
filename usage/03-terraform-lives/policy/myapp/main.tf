locals {
  mount_path = "chechia-net-myapp"
}

resource "vault_policy" "access_myapp" {
  name = "access_myapp"

  policy = <<-EOF
    path "${var.mount_path}/data/database/*" {
      capabilities = ["read", "list"]
    }
  EOF
}
