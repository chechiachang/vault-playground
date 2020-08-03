Cubbyhole response wrapping
===

This is an example to how to wrapping your app to Vault. (Ex. auto-auth your gitlab to use Vault)

https://learn.hashicorp.com/vault/secrets-management/sm-cubbyhole

# Set admin token

Use policy/cubbyhole-wrapping create token(admin) to operate this example

```
export NAME=cubbyhole-wrapping
vault token create -policy=cubbyhole-wrapping -ttl=30m -format=json | tee tokens/${NAME}.json
export TOKEN=$(cat tokens/${NAME}.json | jq -r .auth.client_token)

VAULT_TOKEN=${TOKEN} vault token lookup
```

```
VAULT_TOKEN=${TOKEN} vault policy write apps policy/cubbyhole-wrapping-app.hcl
```
