# policy

https://developer.hashicorp.com/vault/tutorials/policies/policies

# default policy

```
vault policy list

default
root
```

```
vault policy read default

# Allow tokens to look up their own properties
path "auth/token/lookup-self" {
    capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

# Allow a token to look up its own capabilities on a path
path "sys/capabilities-self" {
    capabilities = ["update"]
}

# Allow a token to look up its own entity by id or name
path "identity/entity/id/{{identity.entity.id}}" {
  capabilities = ["read"]
}
path "identity/entity/name/{{identity.entity.name}}" {
  capabilities = ["read"]
}


# Allow a token to look up its resultant ACL from all policies. This is useful
# for UIs. It is an internal path because the format may change at any time
# based on how the internal ACL features and capabilities change.
path "sys/internal/ui/resultant-acl" {
    capabilities = ["read"]
}

# Allow a token to renew a lease via lease_id in the request body; old path for
# old clients, new path for newer
path "sys/renew" {
    capabilities = ["update"]
}
path "sys/leases/renew" {
    capabilities = ["update"]
}

# Allow looking up lease properties. This requires knowing the lease ID ahead
# of time and does not divulge any sensitive information.
path "sys/leases/lookup" {
    capabilities = ["update"]
}

# Allow a token to manage its own cubbyhole
path "cubbyhole/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow a token to wrap arbitrary values in a response-wrapping token
path "sys/wrapping/wrap" {
    capabilities = ["update"]
}

# Allow a token to look up the creation time and TTL of a given
# response-wrapping token
path "sys/wrapping/lookup" {
    capabilities = ["update"]
}

# Allow a token to unwrap a response-wrapping token. This is a convenience to
# avoid client token swapping since this is also part of the response wrapping
# policy.
path "sys/wrapping/unwrap" {
    capabilities = ["update"]
}

# Allow general purpose tools
path "sys/tools/hash" {
    capabilities = ["update"]
}
path "sys/tools/hash/*" {
    capabilities = ["update"]
}

# Allow checking the status of a Control Group request if the user has the
# accessor
path "sys/control-group/request" {
    capabilities = ["update"]
}

# Allow a token to make requests to the Authorization Endpoint for OIDC providers.
path "identity/oidc/provider/+/authorize" {
    capabilities = ["read", "update"]
}
```

```
vault policy read root

No policy named: root
```

# script managed

```
make policy
```

```
vault policy list

admin
database-admin
database-readonly
default
kubernetes-ro
kv-admin
kv-reader
kv-user
root
```

# Use policy

```
vault token create -policy=default

Key                  Value
---                  -----
token                hvs.CAESII2HLqcIdyMbHG824ci9My4mf2pKbqrWQMJZHlWlkYPNGh4KHGh2cy5MdGlCTk9kWWtZSGwyQzBwZlpuUkxTc0Y
token_accessor       xraOVkVFG0l8YSwf67zNoS4x
token_duration       768h
token_renewable      true
token_policies       ["default"]
identity_policies    []
policies             ["default"]

# change to policy=default

export VAULT_TOKEN=hvs.CAESII2HLqcIdyMbHG824ci9My4mf2pKbqrWQMJZHlWlkYPNGh4KHGh2cy5MdGlCTk9kWWtZSGwyQzBwZlpuUkxTc0Y

vault secrets list
```
