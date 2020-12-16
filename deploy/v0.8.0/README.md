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
  -f values.yaml \
  --dry-run
```

# Init

```
kubectl get po -n vault
NAME                                    READY   STATUS    RESTARTS   AGE
vault-0                                 0/1     Running   0          111s
vault-1                                 0/1     Running   0          79s
vault-2                                 0/1     Running   0          75s

kubectl get svc -n vault
NAME                       TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)             AGE
vault                      ClusterIP   10.0.159.0     <none>        8200/TCP,8201/TCP   4m59s
```

```
export VAULT_ADDR=http://127.0.0.1:8200
vault status

Key                Value
---                -----
Seal Type          shamir
Initialized        false
Sealed             true
Total Shares       0
Threshold          0
Unseal Progress    0/0
Unseal Nonce       n/a
Version            n/a
HA Enabled         true

vault operator init
```

unseal
```
declare -a VAULTS=("vault-0" "vault-1" "vault-2")
declare -a KEYS=("key1" "key2" "key3")

for v in ${VAULTS[@]}; do
  for k in ${KEYS[@]}; do
    kubectl exec -it ${v} -n vault vault operator unseal ${k}
  done
done
```
