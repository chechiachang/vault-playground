
# docker-compose up

```
docker-compose up

export CONSUL_HTTP_ADDR=0.0.0.0:8501
export CONSUL_HTTP_SSL_VERIFY=false

consul info
```

# vault

```
export VAULT_ADDR=http://0.0.0.0:8201
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
Version            1.13.2
Build Date         2023-04-25T13:02:50Z
Storage Type       consul
HA Enabled         true
```

### init & unseal

```
vault operator init

Unseal Key 1: XJRajQ22xn9JOtbXogat9iAPtqyVPp07W2wYQp6rW5oZ
Unseal Key 2: eLnaRx9vWjYEOVmUBsMzwFSMsIju2+Hvs5hcRAkk/sGc
Unseal Key 3: 2QlQkrrKwrV5ZG3SvzaXHOzELaqaFK4LhkiuSXubXsJQ
Unseal Key 4: 8YpLixUDia5n0HFmsYsRn+CuA+P7/ZKBHsS4llz7kudV
Unseal Key 5: qsmLHMhWj201ZBvXBhuIyHcuMSr35dvCTjxfOoH9cwqn

Initial Root Token: hvs.HSAtVbFNkh1vsfGGmNuqzqtN

vault operator unseal
Unseal Key (will be hidden):

Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       de25412a-f360-2bc1-d126-ec27094a76e5
Version            1.13.2
Build Date         2023-04-25T13:02:50Z
Storage Type       consul
HA Enabled         true

vault operator unseal
Unseal Key (will be hidden):

Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       de25412a-f360-2bc1-d126-ec27094a76e5
Version            1.13.2
Build Date         2023-04-25T13:02:50Z
Storage Type       consul
HA Enabled         true

vault operator unseal
Unseal Key (will be hidden):

Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.13.2
Build Date      2023-04-25T13:02:50Z
Storage Type    consul
Cluster Name    vault-cluster-59334766
Cluster ID      5e497e64-d94f-e309-45da-e3b99d00f4ad
HA Enabled      true
HA Cluster      https://172.16.238.21:8200
HA Mode         active
Active Since    2023-05-06T17:13:58.4407903Z
```
