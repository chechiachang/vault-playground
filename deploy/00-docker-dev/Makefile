run: 
	docker run --cap-add=IPC_LOCK \
	--volume ./vault/config/:/vault/config.d \
	--volume ./vault/file/:/vault/file \
	--volume ./vault/logs/:/vault/logs \
  -p 8200:8200 \
  --name vault_1 \
	-d \
  hashicorp/vault:1.17.1 \
	vault server -config=/vault/config.d/vault.hcl

rm:
	rm vault/logs/*
	rm vault/file/*
	docker rm -fv vault_1
