PKI
===

- https://learn.hashicorp.com/tutorials/vault/pki-engine
- https://www.hashicorp.com/blog/certificate-management-with-vault/

# WARNING

If use pki engine to generate certificate for Vault server itself. Make sure to have enough lease time for renew. It would cause some trouble during renew if the certificate is invalid.

# Generate

Generate root CA
```
make ca
```

Generate intermediate CA
```
make intermediate
```

Generate certificate for domain
```
make certificate
```

# Usage

### Trust root CA

Mac
```
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" usage/pki/certs/ca/ca.crt
```
