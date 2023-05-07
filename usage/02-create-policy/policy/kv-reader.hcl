# Read-only permit
path "kv-v1/eng/apikey/Google" {
  capabilities = [ "read" ]
}

# Read-only permit
path "kv-v1/prod/cert/mysql" {
  capabilities = [ "read" ]
}
