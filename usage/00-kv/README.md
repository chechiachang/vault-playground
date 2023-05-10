# kv v1

# kv v2

```
vault secrets enable -version=2 -path=chechia -description="kv v2 for chechia" kv

vault secrets list

vault secrets list

Path          Type         Accessor              Description
----          ----         --------              -----------
chechia/      kv           kv_21caa484           n/a

vault kv put chechia/chechia/redis password=87654321

vault kv get chechia/chechia/redis

====== Data ======
Key         Value
---         -----
password    87654321
```
