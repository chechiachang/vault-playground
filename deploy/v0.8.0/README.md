Deploy
===

# Prerequisite

Choose your backend
- https://www.vaultproject.io/docs/configuration/storage/postgresql

# Deploy

Version
- chart: v0.8.0
- vault: v1.5.4

Docs
- https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide
- https://github.com/hashicorp/vault-helm

```
wget https://raw.githubusercontent.com/hashicorp/vault-helm/v0.8.0/values.yaml

helm install vault hashicorp/vault \
    --namespace vault \
    --f values.yml \
    --dry-run
```

# Init

