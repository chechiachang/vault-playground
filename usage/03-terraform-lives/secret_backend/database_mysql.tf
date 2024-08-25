module "database_mysql" {
  source = "../../..//usage/03-terraform-modules/secret_backend/database/mysql"

  mount_path        = "localhost_mariadb"
  mount_description = "Mount for MariaDB on localhost"

  host     = "mariadb_1" # deploy/04-docker-and-db/docker-compose.yaml
  port     = 3306
  database = "" // default to all databases
  username = "root"
  password = "root"
  allowed_roles = {
    "database_admin" = {
      "creation_statements" = [
        "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
        "GRANT ALL PRIVILEGES ON *.* TO '{{name}}'@'%';",
      ]
      "default_ttl" = "1h"
      "max_ttl"     = "24h"
    }
    "database_readonly" = {
      "creation_statements" = [
        "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
        "GRANT SELECT ON *.* TO '{{name}}'@'%';",
      ]
      "default_ttl" = "1h"
      "max_ttl"     = "24h"
    }
    "database_write" = {
      "creation_statements" = [
        "CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';",
        "GRANT INSERT, UPDATE, DELETE ON *.* TO '{{name}}'@'%';",
      ]
      "default_ttl" = "1h"
      "max_ttl"     = "24h"
    }
  }
}
