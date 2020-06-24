# Configure K8s

```
vault auth enable kubernetes
vault auth list
kubectl create serviceaccount vault-auth
kubectl apply -f rbac.yaml
```

# Write config
```
VAULT_SA_NAME=$(kubectl get sa vault-auth -o jsonpath="{.secrets[*]['name']}")
SA_JWT_TOKEN=$(kubectl get secret ${VAULT_SA_NAME} -o jsonpath="{.data.token}" | base64 --decode; echo)
SA_CA_CRT=$(kubectl get secret ${VAULT_SA_NAME} -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)

K8S_HOST="104.199.154.186"

vault write auth/kubernetes/config \
  token_reviewer_jwt="$SA_JWT_TOKEN" \
  kubernetes_host="https://$K8S_HOST:8443" \
  kubernetes_ca_cert="$SA_CA_CRT"
```

# Create readonly role

```
vault write auth/kubernetes/role/example \
  bound_service_account_names=vault-auth \
  bound_service_account_namespaces=default \
  policies=kubernetes-ro \
  ttl=1h
```
