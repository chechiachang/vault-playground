Github
===

https://learn.hashicorp.com/vault/getting-started/authentication

# Config

```
vault auth enable github

vault write auth/github/config organization=nationalteam

vault write auth/github/map/teams/engineering value=default,admin

vault auth help github
```

# Usage

Use Personal Access Token(PAT) with read:org scope.

- Get PAT from Github web page.

```
vault login -method=github token=${PERSONAL_ACCESS_TOKEN}
```
