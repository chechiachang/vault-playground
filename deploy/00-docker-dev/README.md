# 

https://hub.docker.com/r/hashicorp/vault

```
make run
```

Log
- unseal key
- root token

```
You may need to set the following environment variables:

    $ export VAULT_ADDR='http://0.0.0.0:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: FAmaVL8SmbHF/EOuqOpjpgAHOaeJDbDcbwqGsC+gcf8=
Root Token: hvs.seViVcSb9nEAAmodN7YbInwh

Development mode should NOT be used in production installations!
```

# Access vault

```
export VAULT_ADDR=http://0.0.0.0:8200
export VAULT_SKIP_VERIFY=true

vault status

Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.17.1
Build Date      2023-04-25T13:02:50Z
Storage Type    inmem
Cluster Name    vault-cluster-daaf9157
Cluster ID      d7ed0772-3e0a-89d9-d4c6-eaaa77dd1924
HA Enabled      false
```

- already initialized, unsealed
- No HA (HA Enabled: false)

# Authentication

```
vault secrets list

Error listing secrets engines: Error making API request.

URL: GET http://0.0.0.0:8200/v1/sys/mounts
Code: 403. Errors:

* permission denied
```

```
export VAULT_TOKEN=hvs.seViVcSb9nEAAmodN7YbInwh

vault secrets list

Path          Type         Accessor              Description
----          ----         --------              -----------
cubbyhole/    cubbyhole    cubbyhole_ab4b2bb6    per-token private secret storage
identity/     identity     identity_6aaee8d0     identity store
secret/       kv           kv_3228ce5c           key/value secret storage
sys/          system       system_3ebcd1eb       system endpoints used for control, policy and debugging
```

# Clean up

```
docker rm -vf vault_1

vault_1
```
