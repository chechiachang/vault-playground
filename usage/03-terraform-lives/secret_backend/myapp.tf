module "kv2_myapp" {
  source = "../../..//usage/03-terraform-modules/secret_backend/kv_v2"

  mount_path = "chechia-net-myapp"
  description = "Chechia Net My App"
  max_versions = 10
  delete_version_after = "604800" # 168h
  cas_required = true
}
