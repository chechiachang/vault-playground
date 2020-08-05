PostgreSQL database secret engine
===

https://www.vaultproject.io/docs/secrets/databases/postgresql

```
vault secrets enable database

vault write database/config/my-postgresql-database \
  plugin_name=postgresql-database-plugin \
  allowed_roles="my-role" \
  connection_url="postgresql://{{username}}:{{password}}@localhost:5432/" \
  username="vaultuser" \
  password="vaultpass"

vault write database/roles/my-role \
  db_name=my-postgresql-database \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
      GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  default_ttl="1h" \
  max_ttl="24h"
```

# Use

```
vault read database/creds/my-role
```
