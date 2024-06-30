# Run vault in docker with seal

https://hub.docker.com/r/hashicorp/vault

```
make run
```

# Access vault

```
export VAULT_ADDR=http://0.0.0.0:8200
export VAULT_SKIP_VERIFY=true

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
Version            1.17.1
Build Date         2024-06-25T16:33:25Z
Storage Type       file
HA Enabled         false
```

- not initialized, sealed
- No HA (HA Enabled: false)

# Init & unseal

```
make init
make unseal

vault status

Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.17.1
Build Date      2024-06-25T16:33:25Z
Storage Type    file
Cluster Name    vault-cluster-bdeb856d
Cluster ID      f6ed5730-c7dc-7f2f-aab3-d4c307e146b4
HA Enabled      false
```

- initialized, unsealed

# generate-root

https://developer.hashicorp.com/vault/tutorials/operations/generate-root

```
export TOKEN_DIR=tmp
export NONCE=$(vault operator generate-root -init -format json | jq '.nonce')
export OPT=$(vault operator generate-root -init -format json | jq '.opt')

declare -a VAULT_UNSEAL_KEYS=($(cat $TOKEN_DIR/cluster-keys.json | jq -r ".unseal_keys_b64[]" | tr '\n' ' '))

for k in ${VAULT_UNSEAL_KEYS[@]:0:3}; do
    echo $k
done

vault operator generate-root -nonce=$NONCE
vault operator generate-root -nonce=$NONCE
vault operator generate-root -nonce=$NONCE

export ENCODED_ROOT_TOKEN=

vault operator generate-root -decode=$ENCODED_ROOT_TOKEN -otp=$OTP
```

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
