Authenticate in Kubernetes
===

WIP: May not work properly.

https://www.vaultproject.io/docs/auth/kubernetes.html

# Config

### Kubernetes

```

```

### Vault

```
vault auth enable kubernetes

vault write auth/kubernetes/config \
  token_reviewer_jwt="reviewer_service_account_jwt" \
  kubernetes_host=https://192.168.99.100:8443 \
  kubernetes_ca_cert=@ca.crt

vault write auth/kubernetes/role/demo \
  bound_service_account_names=vault-auth \
  bound_service_account_namespaces=default \
  policies=default \
  ttl=1h
```
