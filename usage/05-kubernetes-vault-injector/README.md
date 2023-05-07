
- https://github.com/hashicorp/vault-k8s
- https://github.com/hashicorp/vault-helm

# Install vault injector

```
helm repo add hashicorp https://helm.releases.hashicorp.com
"hashicorp" has been added to your repositories

helm install --values vault-injector.yaml vault hashicorp/vault

helm list

kubectl get po

NAME                                    READY   STATUS    RESTARTS   AGE
vault-agent-injector-1234567890-12345   1/1     Running   0          1h
vault-agent-injector-1234567890-12345   1/1     Running   0          1h
```
