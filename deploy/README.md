Deploy
===

Choose one of the backend storages for vault
- vault HA on postgresql (This readme)
- [vault on Consul key/value](consul.md)

# Vault on PostgreSQL

Update postgresql `connection_url`

```
DIR=vault make vault

  ha:
    config:
      storage:
        postgresql:
          connection_url: "postgres://user123:secret123!@localhost:5432/vault"
```

### Init postgresql database

[Init Guide](https://www.vaultproject.io/docs/configuration/storage/postgresql)

```
kubectl run -i --tty alpine --image=alpine -- sh
apk add postgresql

psql -h host -U devops vault
password:
```

```
CREATE TABLE vault_kv_store (
  parent_path TEXT COLLATE "C" NOT NULL,
  path        TEXT COLLATE "C",
  key         TEXT COLLATE "C",
  value       BYTEA,
  CONSTRAINT pkey PRIMARY KEY (path, key)
);

CREATE INDEX parent_path_idx ON vault_kv_store (parent_path);

CREATE TABLE vault_ha_locks (
  ha_key                                      TEXT COLLATE "C" NOT NULL,
  ha_identity                                 TEXT COLLATE "C" NOT NULL,
  ha_value                                    TEXT COLLATE "C",
  valid_until                                 TIMESTAMP WITH TIME ZONE NOT NULL,
  CONSTRAINT ha_key PRIMARY KEY (ha_key)
);

CREATE FUNCTION vault_kv_put(_parent_path TEXT, _path TEXT, _key TEXT, _value BYTEA) RETURNS VOID AS
$$
BEGIN
    LOOP
        -- first try to update the key
        UPDATE vault_kv_store
          SET (parent_path, path, key, value) = (_parent_path, _path, _key, _value)
          WHERE _path = path AND key = _key;
        IF found THEN
            RETURN;
        END IF;
        -- not there, so try to insert the key
        -- if someone else inserts the same key concurrently,
        -- we could get a unique-key failure
        BEGIN
            INSERT INTO vault_kv_store (parent_path, path, key, value)
              VALUES (_parent_path, _path, _key, _value);
            RETURN;
        EXCEPTION WHEN unique_violation THEN
            -- Do nothing, and loop to try the UPDATE again.
        END;
    END LOOP;
END;
$$
LANGUAGE plpgsql;
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
GIT_VERSION=v0.6.0
CHART_VERSION=0.6.0

cd ha

wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/blob/${GIT_VERSION}/values.yaml

helm install --namespace=vault --values=vault-values.yaml --version ${CHART_VERSION} --dry-run vault hashicorp/vault

helm install --namespace=vault --values=vault-values.yaml --version ${CHART_VERSION} vault hashicorp/vault
```

```
DIR=ha make dry-run
DIR=ha make install
```

### Ingress

```
kubectl apply -f deploy/ha/ingress.yaml
```

### GCP KMS unseal key

https://learn.hashicorp.com/vault/operations/autounseal-gcp-kms
https://github.com/hashicorp/vault-guides/tree/master/operations/gcp-kms-unseal

Service Account 
- Add servivce account, vault-kms-unseal, with roles/cloudkms.cryptoKeyEncrypterDecrypter
- Add secret key to GKE following [GCP official doc](https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform)
- Add volume & env to assign google application credentials to pod

```
kubectl create secret generic vault-kms-key \
  -n vault \
  --from-file=vault-kms-key.json=/Users/david/workspace/credentials/PATH-TO-KEY-FILE.json

kubectl get secrets -n vault
```

Edit helm values
```
  extraEnvironmentVars:
    GOOGLE_APPLICATION_CREDENTIALS: /vault/userconfig/vault-kms-key/vault-kms-key.json

  extraVolumes:
    - type: secret
      name: vault-kms-key
      path: /vault/userconfig

      # End up mount /vault/userconfig/vault-kms-key/vault-kms-key.json
```

Upgrade helm

```
[INFO]  core: stored unseal keys supported, attempting fetch
[WARN]  failed to unseal core: error="stored unseal keys are supported, but none were found"
[INFO]  core.autoseal: seal configuration missing, but cannot check old path as core is sealed: seal_type=recovery

make init

2020-08-06T02:50:09.301Z [INFO]  core: post-unseal setup complete
2020-08-06T02:50:10.062Z [WARN]  core: attempted unseal with stored keys, but vault is already unsealed
```

Check KMS key
```
gcloud kms keys list --location asia-east1 --keyring projects/${PROJECT}/locations/${LOCATION}/keyRings/vault-unseal-key
```

---

# Uninstall

```
helm -n vault delete vault
```

PostgreSQL delete database vault
