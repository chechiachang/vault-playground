SHELL = /bin/bash

dev:
	vault server dev

# Deploy

# DIR=tekton make env
env:
	mkdir $(DIR)
	cd $(DIR); wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/master/values.yaml; wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/master/values.yaml

dry-run:
	#helm install --namespace=vault --values=${DIR}/consul-values.yaml --dry-run vault hashicorp/consul
	helm install --namespace=vault --values=${DIR}/vault-values.yaml --dry-run vault hashicorp/vault

#consul:
#	helm install --namespace=vault --values=${DIR}/consul-values.yaml consul hashicorp/consul

vault:
	helm install --namespace=vault --values=${DIR}/vault-values.yaml vault hashicorp/vault

install: vault
