# Vault init

init:
	kubectl -n vault exec vault-0 -- vault operator init -key-shares=5 -key-threshold=3 -format=json | tee cluster-keys.json

VAULT_UNSEAL_KEYS:=$(shell cat cluster-keys.json | jq -r ".unseal_keys_b64[]" | tr '\n' ' ')
# Use first 3 keys to unseal
unseal:
	declare -a VAULT_UNSEAL_KEYS=($(VAULT_UNSEAL_KEYS)); \
	for v in vault-0 vault-1 vault-2; do \
		for k in $${VAULT_UNSEAL_KEYS[@]:0:3}; do \
			kubectl -n vault exec $$v -- vault operator unseal $$k; sleep 1;\
		done \
	done

# Policy

.PHONY: policy

POLICIES:=$(shell ls policy)
policy:
	declare -a POLICIES=($(POLICIES)); \
	for p in $${POLICIES[@]%.hcl}; do \
		vault policy write $$p policy/$$p.hcl; sleep 1; \
	done
	vault policy list

enable:
	vault secrets enable -path="kv-v1" kv

# Token

user:
	vault token create -period=1h -policy=kv-user -format=json | tee key.json

reader:
	vault token create -period=1h -policy=kv-reader -format=json | tee key.json

login:
	jq .auth.client_token key.json | xargs vault login

root:
	jq .root_token cluster-keys.json | xargs vault login

# Versioning

version:
	vault kv enable-versioning kv-v1
	vault secrets list -detailed

# Warpping

wrap:
	vault token create -policy=reader -wrap-ttl=120
