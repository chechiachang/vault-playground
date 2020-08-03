Vault Playground
===

# Cli

[Download](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_darwin_amd64.zip)

[Linux](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip)

# Deploy

[Check deploy](deploy)

# Initialize

```
make init
make unseal
```

# Access

```
export VAULT_ADDR='http://127.0.0.1:8200'
vault status

export VAULT_TOKEN=''
# export VAULT_TOKEN to avoid login

vault token lookup
```

### Policy

Avoid using root token. Create an admin token to operate.
```
make policy
vault token create -policy=admin -ttl=30m -format=json | tee tokens/admin.json
export VAULT_TOKEN=$(cat tokens/admin.json | jq -r .auth.client_token)

vault token lookup
```

### Secret

KV
```
vault secrets list

vault secrets enable -path=kv kv
vault kv put kv/hello target=world
vault kv list kv/
```

### Token

```
vault token create -policy=default
```

### Auth

```
vault auth help github
vault login -method=github token=""
```

### Policy

```
vault policy fmt my-policy.hcl
```

```
vault policy write my-policy my-policy.hcl

vault policy write my-policy -<<EOF
# Dev servers have version 2 of KV secrets engine mounted by default, so will
# need these paths to grant permissions:
path "secret/data/*" {
  capabilities = ["create", "update"]
}

path "secret/data/foo" {
  capabilities = ["read"]
}
EOF

vault policy read my-policy
```

Use policy
```
vault token create -policy=my-policy
```

### GCP secret engine

---

# Operation

### Runs-on preemptible (Spot) Instance

Pods will down with preemptible instances. New pod will be sealed when init. Require auto-unseal.

- [ ] Auto-unseal
