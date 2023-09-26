# policy
#  ├── database_admin

module "policy_database_admin" {
  source = "../../policy/database_admin"

  path = "chechia-net-myapp/database"
}
