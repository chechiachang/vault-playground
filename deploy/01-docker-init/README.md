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
Version            1.17.6
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
vault operator generate-root -init -format json > $TOKEN_DIR/generate_root.json
export NONCE=$(cat $TOKEN_DIR/generate_root.json | jq -r '.nonce')
export OTP=$(cat $TOKEN_DIR/generate_root.json | jq -r '.otp')

declare -a VAULT_UNSEAL_KEYS=($(cat $TOKEN_DIR/cluster-keys.json | jq -r ".unseal_keys_b64[]" | tr '\n' ' '))

for k in ${VAULT_UNSEAL_KEYS[@]:0:3}; do
    echo $k
done

vault operator generate-root -nonce=$NONCE
vault operator generate-root -nonce=$NONCE
vault operator generate-root -nonce=$NONCE

export ENCODED_ROOT_TOKEN=

export VAULT_TOKEN=$(vault operator generate-root -decode=$ENCODED_ROOT_TOKEN -otp=$OTP)
```

# Authentication

```
vault secrets list

Path          Type         Accessor              Description
----          ----         --------              -----------
cubbyhole/    cubbyhole    cubbyhole_89c7c6cc    per-token private secret storage
identity/     identity     identity_5f3b1608     identity store
sys/          system       system_f5af7df8       system endpoints used for control, policy and debugging
```

# Clean up

```
docker rm -vf vault_1

vault_1
```
