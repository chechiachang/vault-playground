Cert
===

https://developer.hashicorp.com/vault/docs/auth/cert

# Config

```
vault enable auth cert

vault write auth/cert/certs/web \
    display_name=web \
    policies=web,root \
    certificate=@web-cert.pem \
    ttl=3600
```

# Usage

```
vault login \
    -method=cert \
    -ca-cert=vault-ca.pem \
    -client-cert=cert.pem \
    -client-key=key.pem \
    name=web
```
