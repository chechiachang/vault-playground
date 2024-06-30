Vault on Consul
===

[consul helm](https://github.com/hashicorp/consul-helm)

```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/consul

wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml

helm install --namespace=vault --values=vault/consul-values.yaml --dry-run vault hashicorp/consul

helm install --namespace=vault --values=vault/consul-values.yaml consul hashicorp/consul
```

# Install vault with helm
