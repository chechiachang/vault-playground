GCP Service Accoutn
===

Read GCP token / service acount key from vault to interact with GCP API.

https://www.vaultproject.io/docs/secrets/gcp

# Config

### GCP

- Create Service Account vault-auth, with permission
  - iam.serviceAccounts.Admin
  - iam.serviceAccountKeys.Admin
  - resourcemanager.projects.IAMAdmin
- Generate credential-key.json
- [Enable Cloud Resource Manager API](https://console.developers.google.com/apis/api/cloudresourcemanager.googleapis.com/overview)

### Vault

```
vault secrets enable gcp

vault write gcp/config \
  credentials=@vault-auth-credentials.json

GCP_PROJECT=national-team-5g
```

I. Auth access token
```
vault write gcp/roleset/vault-auth-roleset \
  project="${GCP_PROJECT}" \
  secret_type="access_token"  \
  token_scopes="https://www.googleapis.com/auth/cloud-platform" \
  bindings=-<<EOF
    resource "//cloudresourcemanager.googleapis.com/projects/${GCP_PROJECT}" {
      roles = ["roles/viewer"]
    }
EOF
```

II. Auth service account
```
vault write gcp/roleset/vault-auth-key-roleset \
    project="${GCP_PROJECT}" \
    secret_type="service_account_key"  \
    bindings=-<<EOF
      resource "//cloudresourcemanager.googleapis.com/projects/${GCP_PROJECT}" {
        roles = ["roles/viewer"]
      }
EOF
```

### Usage

I. Generate GCP Access Tokens
```
vault read gcp/token/vault-auth-roleset -format=json | tee tokens/gcp-vault-auth.json 

GCP_TOKEN=$(cat tokens/gcp-vault-auth.json | jq .data.token)

curl -H "Authorization: Bearer ${GCP_TOKEN}" gcp/api/...
```

II. Generate Service Account Key
```
vault read gcp/key/vault-auth-roleset
```
