Deploy
===

Choose one of the backend storages for vault
- vault on postgresql (This readme)
- [vault on Consul key/value](consul.md)

# Vault on PostgreSQL

Update postgresql `connection_url`

```
DIR=vault make vault
```

# Install Vault with helm

[vault helm](https://github.com/hashicorp/vault-helm)

Use version 1.3.6 to avoid vault timeout in 1.4.x
Enable raft storage to avoid using consul.
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault
NAME           	CHART VERSION	APP VERSION	DESCRIPTION
hashicorp/vault	0.6.0        	1.4.2      	Official HashiCorp Vault Chart
```

- Fetch values
- Dry run
- Install

```
GIT_VERSION=v6.0.0
CHART_VERSION=v6.0.0

wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/blob/${GIT_VERSION}/values.yaml

helm install --namespace=vault --values=vault/vault-values.yaml --version ${CHART_VERSION} --dry-run vault hashicorp/vault

helm install --namespace=vault --values=vault/vault-values.yaml --version ${CHART_VERSION} vault hashicorp/vault
```

```
DIR=vault make dry-run
DIR=vault make install
```

# Uninstall

```
helm -n vault delete vault
```

PostgreSQL delete database vault
