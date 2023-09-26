module "policy_database_readonly" {
  source = "../../policy/database_write"

  path = "chechia-net-myapp/database"
}
