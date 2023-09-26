# policy
#  ├── database_readonly

module "policy_database_readonly" {
  source = "../../policy/database_readonly"

  path = "chechia-net-myapp/database"
}
