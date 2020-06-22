Vault Playground
===

# Cli

[Download](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_darwin_amd64.zip)

# Vault on Consul

[consul helm](https://github.com/hashicorp/consul-helm)

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/consul

wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml

helm install --namespace=vault --values=${DIR}/consul-values.yaml --dry-run vault hashicorp/consul

helm install --namespace=vault --values=${DIR}/consul-values.yaml consul hashicorp/consul
```

[vault helm](https://github.com/hashicorp/vault-helm)

Use version 1.3.6 to avoid vault timeout in 1.4.x
Enable raft storage to avoid using consul.
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault

wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml

helm install --namespace=vault --values=${DIR}/vault-values.yaml --dry-run vault hashicorp/vault

helm install --namespace=vault --values=${DIR}/vault-values.yaml vault hashicorp/vault
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
```
