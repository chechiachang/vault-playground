SHELL = /bin/bash
VAULT_ADDR = http://127.0.0.1:8200

dev:
	vault server dev

# DIR=tekton make env
env:
	mkdir $(DIR)
	cd $(DIR); wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml; wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml

dry-run:
	helm install --namespace=vault --values=${DIR}/consul-values.yaml --dry-run vault hashicorp/consul
	helm install --namespace=vault --values=${DIR}/vault-values.yaml --dry-run vault hashicorp/vault

consul:
	helm install --namespace=vault --values=${DIR}/consul-values.yaml consul hashicorp/consul

vault:
	helm install --namespace=vault --values=${DIR}/vault-values.yaml vault hashicorp/vault

install: consul vault

init:
	kubectl -n vault exec vault-0 -- vault operator init -key-shares=5 -key-threshold=3 -format=json | tee cluster-keys.json

VAULT_UNSEAL_KEYS:=$(shell cat cluster-keys.json | jq -r ".unseal_keys_b64[]" | tr '\n' ' ')
unseal:
	declare -a VAULT_UNSEAL_KEYS=($(VAULT_UNSEAL_KEYS)); \
	for v in vault-0 vault-1 vault-2; do \
		for k in $${VAULT_UNSEAL_KEYS[@]}; do \
			kubectl -n vault exec $$v -- vault operator unseal $$k; \
		done \
	done
