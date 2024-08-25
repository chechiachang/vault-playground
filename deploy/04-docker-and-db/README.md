# Run dev vault with mariadb

Run a dev vault server with a dev mariadb database.

WARNING: This is for development only. Do not use in production.

### up

```
docker-compose up -d
```

check status

```
docker ps
CONTAINER ID   IMAGE                    COMMAND                  CREATED          STATUS          PORTS                    NAMES
3206989d22f5   mariadb:11.5.2           "docker-entrypoint.s…"   6 minutes ago    Up 6 minutes    0.0.0.0:3306->3306/tcp   04-docker-and-db-mariadb_1-1
20b40952c685   hashicorp/vault:1.17.3   "vault server -dev"      13 minutes ago   Up 13 minutes   0.0.0.0:8200->8200/tcp   04-docker-and-db-vault_1-1
```

### Access vault

download client from https://developer.hashicorp.com/vault/install

```
vault version
Vault v1.17.3 (c91c85442144e1228c02123fc4b19337f7d52700), built 2024-08-06T14:28:45Z
```

access vault server (in docker)

```
export VAULT_ADDR=http://127.0.0.1:8200
vault status
```

### Access MariaDB

```
mysql -h localhost -u root -p
```

# Next steps

check usage/06-database-mysql/README.md

or

go Terraform

```
cd usage/03-terraform-lives/
terragrunt plan
terragrunt apply
```
