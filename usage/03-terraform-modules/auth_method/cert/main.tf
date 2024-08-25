resource "vault_auth_backend" "cert" {
  path = "cert"
  type = "cert"
}

resource "vault_cert_auth_backend_role" "cert" {
  for_each = var.roles

  name            = each.key
  certificate     = file("/vault/certs/ca-cert.pem")
  backend         = vault_auth_backend.cert.path
  allowed_domains = each.value.allowed_domains
  token_policies  = each.value.token_policies
  token_ttl       = each.value.token_ttl
  token_max_ttl   = each.value.token_max_ttl
}

variable "roles" {
  type = map(object({
    allowed_domains = list(string)
    token_policies  = list(string)
    token_ttl       = string
    token_max_ttl   = string
  }))
}
