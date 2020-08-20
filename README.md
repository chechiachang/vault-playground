Vault Playground
===

# Cli

[Download](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_darwin_amd64.zip)

[Linux](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip)

# Deploy

[Check deploy](deploy)

---

# Vault cluster admin operations

### Initialize

```
make init
make unseal
```

### Policy

Avoid using root token. Create an admin token to operate.
```
export VAULT_ADDR='http://127.0.0.1:8200'

make policy
vault token create -policy=admin -ttl=30m -format=json | tee tokens/admin.json
export VAULT_TOKEN=$(cat tokens/admin.json | jq -r .auth.client_token)

vault token lookup
```

### Access (with env)

- avoid use root token
- export `VAULT_TOKEN` to avoid login

```
export VAULT_TOKEN='s.my-token'
export VAULT_CACERT='my-ca.crt' # Required for tls certificate self-signed with ca"

vault token lookup
```

### Access with login

Root switch to admin token
- create token with policy
- vault login

```
POLICY=admin make token
vault token lookup
```

---

# Vault user usage

- avoid use root token

```
export VAULT_ADDR='http://127.0.0.1:8200'
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

---

# Operation

### Runs-on preemptible (Spot) Instance

Pods will down with preemptible instances. New pod will be sealed when init. Require auto-unseal.

Work around: unseal -> login root -> create admin -> login admin
```
make unseal root admin
```
