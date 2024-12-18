.PHONY: run logs init unseal generate-root rm

run: 
	docker run --cap-add=IPC_LOCK \
	--volume ./vault/config/:/vault/config.d \
	--volume ./tmp/vault/file/:/vault/file \
	--volume ./tmp/vault/logs/:/vault/logs \
  -p 8200:8200 \
  --name vault_0 \
	-d \
  hashicorp/vault:1.17.6 \
	vault server -config=/vault/config.d/vault.hcl

logs:
	docker logs -f vault_0


TOKEN_DIR := tmp

init:
	vault operator init -key-shares=5 -key-threshold=3 -format=json | tee ${TOKEN_DIR}/cluster-keys.json

unseal:
	declare -a VAULT_UNSEAL_KEYS=($(shell cat $(TOKEN_DIR)/cluster-keys.json | jq -r ".unseal_keys_b64[]" | tr '\n' ' ')); \
	for k in $${VAULT_UNSEAL_KEYS[@]:0:3}; do \
		vault operator unseal $$k; sleep 1; \
	done

rm:
	rm -rf tmp/*
	docker rm -fv vault_0
