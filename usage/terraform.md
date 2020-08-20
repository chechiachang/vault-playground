Use Vault credentials in Terraform
===

https://www.terraform.io/docs/providers/vault/index.html

# Concept

- Save credentials in Vault
- Terraform use vault provider
  - Vault generate token with short ttl (default 20 mins)
  - Terraform use token to fetch credentials. Terraform apply.
    - Terraform state will have token, which will shortly become invalid

# Usage

```
export VAULT_CACERT=pki/certs/ca/ca.crt
```
