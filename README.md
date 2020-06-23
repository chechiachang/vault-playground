Vault Playground
===

# Cli

[Download](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_darwin_amd64.zip)

[Linux](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip)

# Vault on Consul

[consul helm](https://github.com/hashicorp/consul-helm)

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/consul

wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml

helm install --namespace=vault --values=deploy/singleton/consul-values.yaml --dry-run vault hashicorp/consul

helm install --namespace=vault --values=deploy/singleton/consul-values.yaml consul hashicorp/consul
```

[vault helm](https://github.com/hashicorp/vault-helm)

Use version 1.3.6 to avoid vault timeout in 1.4.x
Enable raft storage to avoid using consul.
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault

wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml

helm install --namespace=vault --values=deploy/singleton/vault-values.yaml --dry-run vault hashicorp/vault

helm install --namespace=vault --values=deploy/singleton/vault-values.yaml vault hashicorp/vault
```

```
DIR=consul make dry-run
DIR=consul make install
```

# Vault on PostgreSQL

Update postgresql `connection_url`

```
DIR=tekton make vault
```

# Initialize

```
make init
make unseal
```

# Access

```
export VAULT_ADDR='http://127.0.0.1:8200'
vault status

vault login
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

