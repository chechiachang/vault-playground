run: 
	docker run --cap-add=IPC_LOCK \
  -v config:/vault/config.d \
  -p 8200:8200 \
  --name vault_1 \
	-d \
  hashicorp/vault:1.14.3
