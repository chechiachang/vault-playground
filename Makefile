
TOKEN_DIR := tokens

# === Vault init ===

init:
	kubectl -n vault exec vault-0 -- vault operator init -key-shares=5 -key-threshold=3 -format=json | tee $(TOKEN_DIR)/cluster-keys.json

VAULT_UNSEAL_KEYS:=$(shell cat $(TOKEN_DIR)/cluster-keys.json | jq -r ".unseal_keys_b64[]" | tr '\n' ' ')
# Use first 3 keys to unseal
unseal:
	declare -a VAULT_UNSEAL_KEYS=($(VAULT_UNSEAL_KEYS)); \
	for v in vault-0 vault-1 vault-2; do \
		for k in $${VAULT_UNSEAL_KEYS[@]:0:3}; do \
			kubectl -n vault exec $$v -- vault operator unseal $$k; sleep 1;\
		done \
	done

# === Policy ===

.PHONY: policy

POLICIES:=$(shell ls policy)
policy:
	declare -a POLICIES=($(POLICIES)); \
	for p in $${POLICIES[@]%.hcl}; do \
		vault policy write $$p policy/$$p.hcl; sleep 1; \
	done
	vault policy list

# === Usage ===

# Token

token:
	vault token create -period=1h -policy=$${POLICY} -format=json | tee $(TOKEN_DIR)/keys.json
	jq .auth.client_token $(TOKEN_DIR)/keys.json | xargs vault login

root:
	jq .root_token $(TOKEN_DIR)/cluster-keys.json | xargs vault login

admin:
	POLICY=admin make token

# Versioning

version:
	vault kv enable-versioning kv-v1
	vault secrets list -detailed

# Warpping

wrap:
	vault token create -policy=kv-reader -wrap-ttl=120 -format=json | tee $(TOKEN_DIR)/wrap.keys.json

unwrap:
	jq .wrap_info.token $(TOKEN_DIR)/wrap.json | xargs vault unwrap

# Secret engine

enable:
	vault secrets enable -path="kv-v1" kv

# database
# - config/postgresql
# - roles/readonly
# - creds

database-admin:
	POLICY=database-admin make token

database: database-admin
	# vault secrets enable database
	vault write database/config/postgresql \
    plugin_name=postgresql-database-plugin \
    allowed_roles=readonly \
    connection_url='postgresql://root:rootpassword@localhost:5432/postgres?sslmode=disable'
	vault write database/roles/readonly db_name=postgresql \
    creation_statements=@usage/database/postgresql-readonly.sql \
    default_ttl=1h max_ttl=24h

database-readonly:
	POLICY=database-readonly make token

database-access: database-readonly
	vault read database/creds/readonly

database-lease:
	vault list -format=json sys/leases/lookup/database/creds/readonly

database-revoke: database-lease
	vault list -format=json sys/leases/lookup/database/creds/readonly \
		| jq -r '.[]' \
		| xargs -I '{}' vault lease revoke database/creds/readonly/{}

# make sure this root key is dedicated for vault. Any other sharing apps will break.
database-rotate-root:
	vault write -force database/rotate-root/postgresql
