# Write and manage secrets in key/value secrets engine
path "kv-v1/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# Create tokens for verification & test
path "auth/token/create" {
  capabilities = [ "create" ]
}
