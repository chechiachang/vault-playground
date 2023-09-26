resource "vault_github_auth_backend" "main" {
  organization = var.organization
  path         = var.path
  description  = var.description
}

resource "vault_github_team" "team" {
  for_each = toset(var.teams)

  backend  = vault_github_auth_backend.main.id
  team     = each.value["team"]
  policies = each.value["policies"]
}

resource "vault_github_user" "user" {
  for_each = toset(var.users)

  backend  = vault_github_auth_backend.main.id
  user     = each.value["user"]
  policies = each.value["policies"]
}

variable "organization" {
  type = string
}

variable "path" {
  type = string
}

variable "description" {
  type = string
}

variable "teams" {
  type = list(object({
    team     = string
    policies = list(string)
  }))
  default     = []
  description = "List of teams to create"
}

variable "users" {
  type = list(object({
    user     = string
    policies = list(string)
  }))
  default     = []
  description = "List of users to create"
}

