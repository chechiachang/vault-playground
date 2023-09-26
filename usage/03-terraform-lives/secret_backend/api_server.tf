module "kv2_api_server" {
  source = "../../..//usage/03-terraform-modules/secret_backend/kv_v2"

  mount_path = "chechia-net-api-server"
  description = "Chechia Net API Server"
  max_versions = 10
  delete_version_after = "604800" # 168h
  cas_required = true
}
