GCP OIDC
===

- [Vault OIDC](https://github.com/hashicorp/vault-guides/tree/master/identity/oidc-auth#configure-google)
- Config GCP
  - [Oauth 2.0 to Google APIs](https://developers.google.com/identity/protocols/oauth2)
  - [Community Doc by VMware](https://docs.run.pivotal.io/sso/gcp/config-gcp.html)
- [Vault auth OIDC](https://www.vaultproject.io/docs/auth/jwt#configuration)

# Configs

### GCP

1. Visit the Google API Console.
1. Create or a select a project.
1. Create a new credential via IAM Service Account Credential API > Credentials > Create Credentials > OAuth Client ID.
1. Configure the OAuth Consent Screen. Application Name is required. Save.
1. Select application type: "Web Application".
1. Configure Authorized Redirect URIs. ex. https://${DOMAIN}/ui/vault/auth/oidc/oidc/callback
1. Save client ID and secret.

### Vault

```
vault auth enable oidc

CLIENT_ID=

CLIENT_SECRET=

vault write auth/oidc/config \
  oidc_discovery_url="https://accounts.google.com" \
  oidc_client_id="${CLIENT_ID}" \
  oidc_client_secret="${CLIENT_SECRET}" \
  default_role="gmail"

vault write auth/oidc/role/gmail \
  user_claim="sub" \
  bound_audiences=${CLIENT_ID} \
  allowed_redirect_uris=https://vault.chechia.in/ui/vault/auth/oidc/oidc/callback \
  policies=default \
  ttl=1h
```

# Usage

Vault UI login
  - method: oidc
  - role: gmail
  - login with gmail
