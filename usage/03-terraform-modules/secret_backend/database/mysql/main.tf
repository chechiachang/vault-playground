resource "vault_database_secrets_mount" "mysql" {
  path        = var.mount_path
  description = var.mount_description

  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds

  mysql {
    name           = var.mount_path
    plugin_name    = "mysql-database-plugin"
    connection_url = "{{username}}:{{password}}@tcp(${var.host}:${var.port})/${var.database}"
    username       = var.username
    password       = var.password
    allowed_roles  = keys(var.allowed_roles)

    username_template = "chechia-{{.RoleName}}-{{random 8}}"
    verify_connection = true
  }
}

resource "vault_database_secret_backend_role" "vault_roles" {
  for_each = var.allowed_roles

  backend             = vault_database_secrets_mount.mysql.path
  name                = each.key
  db_name             = vault_database_secrets_mount.mysql.path
  creation_statements = each.value.creation_statements
}
