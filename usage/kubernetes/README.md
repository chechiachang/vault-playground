Access vault in Kubernetes
===

Given existing secret

```
vault secrets enable -path=myapp kv
vault kv put myapp/config username='appuser' \
  password='suP3rsec(et!' \
  ttl='30s'
```

Get token inside Pod

- Manual auth whith AWT & API
- Auto-auth

### Configure K8s

```
vault auth enable kubernetes
vault auth list
kubectl create serviceaccount vault-auth
kubectl apply -f rbac.yaml
```

### Write config

```
SERVICE_ACCOUNT=vault-auth
VAULT_SA_NAME=$(kubectl get sa vault-auth -o jsonpath="{.secrets[*]['name']}")
SA_JWT_TOKEN=$(kubectl get secret ${VAULT_SA_NAME} -o jsonpath="{.data.token}" | base64 --decode; echo)
SA_CA_CRT=$(kubectl get secret ${VAULT_SA_NAME} -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)

K8S_HOST="104.199.154.186"

vault write auth/kubernetes/config \
  token_reviewer_jwt="$SA_JWT_TOKEN" \
  kubernetes_host="https://$K8S_HOST" \
  kubernetes_ca_cert="$SA_CA_CRT"

vault read auth/kubernetes/config
```

### Create readonly role (map sa to policy)

```
VAULT_ROLE=kubernetes-ro
VAULT_POLICY=kubernetes-ro
vault write auth/kubernetes/role/${VAULT_ROLE} \
      bound_service_account_names=vault-auth \
      bound_service_account_namespaces=default \
      policies=${VAULT_POLICY} \
      ttl=24h

vault read auth/kubernetes/role/kubernetes-ro
```

### Auth

Client Pod

```
kubectl run --generator=run-pod/v1 tmp --rm -i --tty \
      --serviceaccount=vault-auth --image alpine:3.7

KUBE_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
echo $KUBE_TOKEN

curl --request POST \
     --data '{"jwt": "'"$KUBE_TOKEN"'", "role": "'"${VAULT_ROLE}"'"}' \
      http://testvault.silkrode.com.tw/v1/auth/kubernetes/login | tee vault-key.json
```

# Auto auth

```
kubectl apply -f configmap.yaml --record
kubectl apply -f pod.yaml --record

kubectl exec -it vault-agent-alpine sh
```
