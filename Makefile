
VAULT_ADDR = http://127.0.0.1:8200

dev:
	vault server dev

# DIR=tekton make env
env:
	mkdir $(DIR)
	cd $(DIR); wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml; wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml
