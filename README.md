Vault Playground
===

Case study to learn and test HashiCorp Vault.

### Vault

[Download](https://releases.hashicorp.com/vault/)

### Deploy

[Check deploy](deploy)

### Usage

[Check usage](usage)

# Case: docker vault and postgresql

deploy vault and postgresql with docker-compose
- vault is in dev mode

```
cd deploy/03-docker-and-db
docker-compose up -d
```

Configure vault

```
cd usage/03-terraform-lives

terragrunt init
terragrunt plan
terragrunt apply
```

Use vault
