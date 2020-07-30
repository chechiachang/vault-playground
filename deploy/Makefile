SHELL = /bin/bash

dev:
	vault server dev

# Deploy

# DIR=vault make env
VERSION := "v6.0.0"
env:
	mkdir $(DIR)
	cd $(DIR); wget -O consul-values.yaml https://raw.githubusercontent.com/hashicorp/consul-helm/blob/$(VERSION)/values.yaml; wget -O vault-values.yaml https://raw.githubusercontent.com/hashicorp/vault-helm/blob/$(VERSION)/values.yaml

dry-run:
	helm install --namespace=vault --values=${DIR}/vault-values.yaml --dry-run vault hashicorp/vault

#consul:
	#helm install --namespace=vault --values=${DIR}/consul-values.yaml --dry-run vault hashicorp/consul
	#helm install --namespace=vault --values=${DIR}/consul-values.yaml consul hashicorp/consul

vault:
	helm install --namespace=vault --values=${DIR}/vault-values.yaml vault hashicorp/vault

install: vault
