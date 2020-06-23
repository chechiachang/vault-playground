Deploy
===

# Vault on Consul

[consul helm](https://github.com/hashicorp/consul-helm)

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/consul

wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml

helm install --namespace=vault --values=tekton/consul-values.yaml --dry-run vault hashicorp/consul

helm install --namespace=vault --values=tekton/consul-values.yaml consul hashicorp/consul
```

[vault helm](https://github.com/hashicorp/vault-helm)

Use version 1.3.6 to avoid vault timeout in 1.4.x
Enable raft storage to avoid using consul.
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault

wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml

helm install --namespace=vault --values=tekton/vault-values.yaml --dry-run vault hashicorp/vault

helm install --namespace=vault --values=tekton/vault-values.yaml vault hashicorp/vault
```

```
DIR=tekton make dry-run
DIR=tekton make install
```

# Vault on PostgreSQL

Update postgresql `connection_url`

```
DIR=tekton make vault
```
