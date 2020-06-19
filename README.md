Vault Playground
===

# Cli

[Download](https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_darwin_amd64.zip)

# Server (helm)

[consul helm](https://github.com/hashicorp/consul-helm)

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/consul

wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml

helm install --namespace=vault --values=consul-values.yaml --dry-run vault hashicorp/consul

helm install --namespace=vault --values=consul-values.yaml consul hashicorp/consul
```

[vault helm](https://github.com/hashicorp/vault-helm)

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault

wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml

helm install --namespace=vault --values=vault-values.yaml --dry-run vault hashicorp/vault

helm install --namespace=vault --values=vault-values.yaml vault hashicorp/vault
```

Initialize
```
kubectl exec vault-0 -- vault operator init -key-shares=5 -key-threshold=3 -format=json | tee cluster-keys.json
cat cluster-keys.json | jq -r ".unseal_keys_b64[]"
```
