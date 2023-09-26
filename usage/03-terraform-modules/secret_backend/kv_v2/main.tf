resource "vault_mount" "kvv2" {
  path        = var.mount_path
  type        = "kv"
  options     = { version = "2" }
  description = var.description
}

resource "vault_kv_secret_backend_v2" "example" {
  mount                = vault_mount.kvv2.path
  max_versions         = var.max_versions
  delete_version_after = var.delete_version_after
  cas_required         = var.cas_required
}

variable "mount_path" {
  type        = string
  description = "The path where the KVv2 secrets engine will be mounted"
}

variable "description" {
  type        = string
  description = "The description of the KVv2 secrets engine"
}

variable "max_versions" {
  type        = number
  description = "The maximum number of versions to keep per secret"
  default     = 10
}

variable "delete_version_after" {
  type        = number
  description = "The number of seconds after which to delete a version of a secret"
  default     = 12600
}

variable "cas_required" {
  type        = bool
  description = "Whether to require the use of the CAS parameter for all write operations"
  default     = true
}
