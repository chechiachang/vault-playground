SHELL := /bin/bash
.PHONY: all ca

all: ca intermediate role certificate

CA_COMMON_NAME := "Chechia.net Root CA"
ROOT_ENDPOINT := "pkica"
ca:
	# Enable endpoint
	vault secrets enable -path=$(ROOT_ENDPOINT) -description="pki for chechia-net ca"  pki
	# Set lease to 1 year
	vault secrets tune -max-lease-ttl=87600h $(ROOT_ENDPOINT)
	# Generate self-signed root CA & save CA cert
	mkdir -p certs/ca
	vault write -field=certificate $(ROOT_ENDPOINT)/root/generate/internal \
	  common_name=$(CA_COMMON_NAME) \
	  ttl=87600h > certs/ca/ca.crt
	# Configure URLs
	vault write $(ROOT_ENDPOINT)/config/urls \
	  issuing_certificates="http://127.0.0.1:8200/v1/$(ROOT_ENDPOINT)/ca" \
	  crl_distribution_points="http://127.0.0.1:8200/v1/$(ROOT_ENDPOINT)/crl"

.PHONY: intermediate

INTER_COMMON_NAME := "Chechia.net Intermediate Authority"
INTER_ENDPOINT := "pkiintermediate"
intermediate:
	vault secrets enable -path=$(INTER_ENDPOINT) -description="pki for chechia-net intermediate" pki
	vault secrets tune -max-lease-ttl=43800h $(INTER_ENDPOINT)
	# Generate intermediate CA CSR
	mkdir -p certs/intermediate
	vault write -format=json $(INTER_ENDPOINT)/intermediate/generate/internal \
        common_name=$(INTER_COMMON_NAME) \
        | jq -r '.data.csr' > certs/intermediate/intermediate.csr
	# Sign intermediate CA CSR with Root CA
	vault write -format=json $(ROOT_ENDPOINT)/root/sign-intermediate \
		csr=@certs/intermediate/intermediate.csr \
    format=pem_bundle ttl=43800h \
    | jq -r '.data.certificate' > certs/intermediate/intermediate.cert.pem
	# Import intermediate CA cert back to vault
	vault write $(INTER_ENDPOINT)/intermediate/set-signed \
		certificate=@certs/intermediate/intermediate.cert.pem

.PHONY: role certificate

ROLE_NAME := "chechia-net"
ALLOWED_DOMAINS := "chechia.net"
role:
	# Create role to intermediate
	vault write $(INTER_ENDPOINT)/roles/$(ROLE_NAME) \
    allowed_domains=$(ALLOWED_DOMAINS) \
    allow_subdomains=true \
    max_ttl=8760h

ISSUE_NAME := "chechia-net"
DOMAIN := "test.chechia.net"
certificate:
	# Create issue. Private key only show when generated
	mkdir -p certs/$(DOMAIN)
	vault write -format=json $(INTER_ENDPOINT)/issue/$(ISSUE_NAME) \
		common_name=$(DOMAIN) ttl=8760h \
    | tee certs/$(DOMAIN)/tls.json
	cat certs/$(DOMAIN)/tls.json | jq -r '.data.certificate' > certs/$(DOMAIN)/tls.crt
	cat certs/$(DOMAIN)/tls.json | jq -r '.data.private_key' > certs/$(DOMAIN)/tls.key
	cat certs/$(DOMAIN)/tls.json | jq -r '.data.ca_chain[0]' > certs/$(DOMAIN)/ca_chain.crt
	cat certs/$(DOMAIN)/tls.json | jq -r '.data.issuing_ca' > certs/$(DOMAIN)/ca.crt

revoke:
	vault write $(INTER_ENDPOINT)/revoke serial_number=""

remove:
	vault write $(INTER_ENDPOINT)/tidy tidy_cert_store=true tidy_revoked_certs=true
