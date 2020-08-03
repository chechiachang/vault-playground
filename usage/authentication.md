Authentication
=== 

https://www.vaultproject.io/docs/concepts/auth

- [GCP](https://www.vaultproject.io/docs/auth/gcp): Use gcp credentials to get access to vault
  - Use iam service-account to access vault
  - Use gce instance to access vault

In use
---

# GCP

### Setup

```
vault auth enable gcp
```

GCP Service account
- roles/iam.serviceAccountKeyAdmin
- roles/compute.viewer
- roles/iam.serviceAccountTokenCreator

### Access

```
vault auth help gcp

PROJECT=my-project
export GOOGLE_APPLICATION_CREDENTIALS=/Users/david/workspaces/credentials/${PROJECT}-vault-auth.json

gcloud beta iam service-accounts sign-jwt \
    --iam-account=vault-auth@${PROJECT}.iam.gserviceaccount.com \
    --project=${PROJECT} \
    usage/input-jwt-claims.json output.jwt

vault login -method=gcp \
    role="my-role" \
    service_account="vault-auth@${PROJECT}.iam.gserviceaccount.com" \
    project=${PROJECT} \
    jwt_exp="15m" \
    credentials=/Users/david/workspaces/credentials/${PROJECT}-vault-auth.json
```

Experimental
---

# Userpass

```
vault auth enable userpass
# or (identical)
vault write sys/auth/userpass type=userpass
```

# Github

Enable
```
vault auth enable userpass
# or (identical)
vault write sys/auth/github type=github
```

Usage
```
vault login -method=github token=${TOKEN}
```
