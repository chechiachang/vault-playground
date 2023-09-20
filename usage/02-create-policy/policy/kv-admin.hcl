# Enable key/value secrets engine at the kv-v1 path
path "sys/mounts/kv-v1" {
  capabilities = ["update"]
}

# To list the available secrets engines
path "sys/mounts" {
  capabilities = ["read"]
}

# Write and manage secrets in key/value secrets engine
path "kv-v1/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Create policies to permit apps to read secrets
path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Create tokens for verification & test
path "auth/token/create" {
  capabilities = ["create", "update", "sudo"]
}
