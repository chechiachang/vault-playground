ui            = true
disable_mlock = true

storage "file" {
  path    = "vault"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = "true"
  default_lease_ttl = "168h"
  max_lease_ttl = "720h"
}
