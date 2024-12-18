run: 
	docker run --cap-add=IPC_LOCK \
  -p 8200:8200 \
	-e 'VAULT_DEV_ROOT_TOKEN_ID=chechia!23' \
	-e 'VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200' \
  --name vault_0 \
	-d \
  hashicorp/vault:1.17.6 \
	vault server -dev

logs:
	docker logs -f vault_0

login:
	vault login

rm:
	rm -rf tmp/*
	docker rm -fv vault_0
