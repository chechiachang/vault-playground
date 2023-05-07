PKI
===

- https://learn.hashicorp.com/tutorials/vault/pki-engine
- https://developer.hashicorp.com/vault/api-docs/secret/pki#read-issuer-certificate
- https://www.hashicorp.com/blog/certificate-management-with-vault/

# WARNING

If use pki engine to generate certificate for Vault server itself. Make sure to have enough lease time for renew. It would cause some trouble during renew if the certificate is invalid.

# Generate

### Generate root CA

```
make ca

Key                        Value
---                        -----
crl_distribution_points    [http://127.0.0.1:8200/v1/pkica/crl]
enable_templating          false
issuing_certificates       [http://127.0.0.1:8200/v1/pkica/ca]
ocsp_servers               []
```

Get ca

```
vault secrets list

Path          Type         Accessor              Description
----          ----         --------              -----------
pkica/        pki          pki_0ca56cfb          pki for chechia-net certifiate

vault read /pkica/cert/ca

Key                        Value
---                        -----
certificate                -----BEGIN CERTIFICATE-----
MIIDLTCCAhWgAwIBAgIUd5xW8xLNuWxfzNxWBK1NLqA1JnIwDQYJKoZIhvcNAQEL
BQAwHjEcMBoGA1UEAxMTQ2hlY2hpYS5uZXQgUm9vdCBDQTAeFw0yMzA1MDcxMzU1
MDhaFw0zMzA1MDQxMzU1MzdaMB4xHDAaBgNVBAMTE0NoZWNoaWEubmV0IFJvb3Qg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGrZVyCsJHWzXSSjJn
9kMrKvuGNuDIcj4uJnk1B6MCDiTnaezmqQwJdDa/h7fFhS12JlziHgokJs1h1OSW
FCD9PVss4djQmcsKhzmX8b2IlT9Dm5qLFqD2FxTM4HRJrm1mtuikxXIg+NvxJIHQ
yP6iB2U/1vfLPvNflJhrPKFQG6Z9fRF9cO9SwAinxNovogAJqdxvnvuTHj6b2xkl
HMHGvP4qgVk/7OHbQ3F8Nset5zo4g98BR87Dnd/Gc/rU7inYIa7S9+8WisZCxkib
3P3OeRkV4Fi7R79GMp+KE+SEVq9Z6elUY3WED7q4tyAUqTFhLL7sbzxh0jGBTgxS
zEtHAgMBAAGjYzBhMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0G
A1UdDgQWBBTJqj8GSKamRNOQrLTu7TO/tFodujAfBgNVHSMEGDAWgBTJqj8GSKam
RNOQrLTu7TO/tFodujANBgkqhkiG9w0BAQsFAAOCAQEAuoD4QdhhqCY6jpZcLfgT
dC6w7GPXJjX/22LD5IHw3ceACP4VXbPrmhIRP96J8mhWpcMH+ENN+dwSNwv/NJbK
TI60qrLVCsf52Qjp7eTdyWGspiJw5txkjO45ch5SM3cB+0yeSTq/EIEeIuf15JT3
zLrcnzbAsoc6gKVoWbuxKVIrjczjSDYFEmRjVX9a39nBbVOmM1ZTWFGMNsRE6RLD
18Q50B+hMfF4bPvLBl2fr1i6uOYWJ6IN2ZfckgVnRdaqeTuKUAUCuGCjZxPA6cIK
1DvMYiqKyqEC1xMJdMBUkUd8ZGWP6aHy95IckqYqtEdVRr0UIIOGfc+lSyfFnJd3
MA==
-----END CERTIFICATE-----
revocation_time            0
revocation_time_rfc3339    n/a
```

Check key

```
vault list pkica/keys

Keys
----
51d56727-7e19-8b13-50cf-ab57d2b7fae0
```

### Generate intermediate CA
```
make intermediate

Key                 Value
---                 -----
imported_issuers    [0f473a27-f6b5-cf09-8039-7f22cb2fa0d7 305a4c33-a73d-7b44-cb5e-7a52cf684f5f]
imported_keys       <nil>
mapping             map[0f473a27-f6b5-cf09-8039-7f22cb2fa0d7:c51cd41a-3aee-1de6-08c2-0f3020cfe284 305a4c33-a73d-7b44-cb5e-7a52cf684f5f:]
```

Check key

```
vault list pkiintermediate/keys

Keys
----
c51cd41a-3aee-1de6-08c2-0f3020cfe284
```

### Generate role policy for management

```
make role

vault list pkiintermediate/roles

Keys
----
chechia-net

vault read pkiintermediate/roles/chechia-net

Key                                   Value
---                                   -----
allow_any_name                        false
allow_bare_domains                    false
allow_glob_domains                    false
allow_ip_sans                         true
allow_localhost                       true
allow_subdomains                      true
allow_token_displayname               false
allow_wildcard_certificates           true
allowed_domains                       [chechia.net]
allowed_domains_template              false
allowed_other_sans                    []
allowed_serial_numbers                []
allowed_uri_sans                      []
allowed_uri_sans_template             false
allowed_user_ids                      []
basic_constraints_valid_for_non_ca    false
client_flag                           true
cn_validations                        [email hostname]
code_signing_flag                     false
country                               []
email_protection_flag                 false
enforce_hostnames                     true
ext_key_usage                         []
ext_key_usage_oids                    []
generate_lease                        false
issuer_ref                            default
key_bits                              2048
key_type                              rsa
key_usage                             [DigitalSignature KeyAgreement KeyEncipherment]
locality                              []
max_ttl                               8760h
no_store                              false
not_after                             n/a
not_before_duration                   30s
organization                          []
ou                                    []
policy_identifiers                    []
postal_code                           []
province                              []
require_cn                            true
server_flag                           true
signature_bits                        256
street_address                        []
ttl                                   0s
use_csr_common_name                   true
use_csr_sans                          true
use_pss                               false
```

### Generate certificate for domain

```
make certificate
```

Get issuer

```
vault list pkiintermediate/issuers

Keys
----
0f473a27-f6b5-cf09-8039-7f22cb2fa0d7
305a4c33-a73d-7b44-cb5e-7a52cf684f5f

vault read pkiintermediate/issuer/0f473a27-f6b5-cf09-8039-7f22cb2fa0d7

Key                               Value
---                               -----
ca_chain                          [-----BEGIN CERTIFICATE-----
MIIDLTCCAhWgAwIBAgIUd5xW8xLNuWxfzNxWBK1NLqA1JnIwDQYJKoZIhvcNAQEL
BQAwHjEcMBoGA1UEAxMTQ2hlY2hpYS5uZXQgUm9vdCBDQTAeFw0yMzA1MDcxMzU1
MDhaFw0zMzA1MDQxMzU1MzdaMB4xHDAaBgNVBAMTE0NoZWNoaWEubmV0IFJvb3Qg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGrZVyCsJHWzXSSjJn
9kMrKvuGNuDIcj4uJnk1B6MCDiTnaezmqQwJdDa/h7fFhS12JlziHgokJs1h1OSW
FCD9PVss4djQmcsKhzmX8b2IlT9Dm5qLFqD2FxTM4HRJrm1mtuikxXIg+NvxJIHQ
yP6iB2U/1vfLPvNflJhrPKFQG6Z9fRF9cO9SwAinxNovogAJqdxvnvuTHj6b2xkl
HMHGvP4qgVk/7OHbQ3F8Nset5zo4g98BR87Dnd/Gc/rU7inYIa7S9+8WisZCxkib
3P3OeRkV4Fi7R79GMp+KE+SEVq9Z6elUY3WED7q4tyAUqTFhLL7sbzxh0jGBTgxS
zEtHAgMBAAGjYzBhMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0G
A1UdDgQWBBTJqj8GSKamRNOQrLTu7TO/tFodujAfBgNVHSMEGDAWgBTJqj8GSKam
RNOQrLTu7TO/tFodujANBgkqhkiG9w0BAQsFAAOCAQEAuoD4QdhhqCY6jpZcLfgT
dC6w7GPXJjX/22LD5IHw3ceACP4VXbPrmhIRP96J8mhWpcMH+ENN+dwSNwv/NJbK
TI60qrLVCsf52Qjp7eTdyWGspiJw5txkjO45ch5SM3cB+0yeSTq/EIEeIuf15JT3
zLrcnzbAsoc6gKVoWbuxKVIrjczjSDYFEmRjVX9a39nBbVOmM1ZTWFGMNsRE6RLD
18Q50B+hMfF4bPvLBl2fr1i6uOYWJ6IN2ZfckgVnRdaqeTuKUAUCuGCjZxPA6cIK
1DvMYiqKyqEC1xMJdMBUkUd8ZGWP6aHy95IckqYqtEdVRr0UIIOGfc+lSyfFnJd3
MA==
-----END CERTIFICATE-----
]
certificate                       -----BEGIN CERTIFICATE-----
MIIDLTCCAhWgAwIBAgIUd5xW8xLNuWxfzNxWBK1NLqA1JnIwDQYJKoZIhvcNAQEL
BQAwHjEcMBoGA1UEAxMTQ2hlY2hpYS5uZXQgUm9vdCBDQTAeFw0yMzA1MDcxMzU1
MDhaFw0zMzA1MDQxMzU1MzdaMB4xHDAaBgNVBAMTE0NoZWNoaWEubmV0IFJvb3Qg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGrZVyCsJHWzXSSjJn
9kMrKvuGNuDIcj4uJnk1B6MCDiTnaezmqQwJdDa/h7fFhS12JlziHgokJs1h1OSW
FCD9PVss4djQmcsKhzmX8b2IlT9Dm5qLFqD2FxTM4HRJrm1mtuikxXIg+NvxJIHQ
yP6iB2U/1vfLPvNflJhrPKFQG6Z9fRF9cO9SwAinxNovogAJqdxvnvuTHj6b2xkl
HMHGvP4qgVk/7OHbQ3F8Nset5zo4g98BR87Dnd/Gc/rU7inYIa7S9+8WisZCxkib
3P3OeRkV4Fi7R79GMp+KE+SEVq9Z6elUY3WED7q4tyAUqTFhLL7sbzxh0jGBTgxS
zEtHAgMBAAGjYzBhMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0G
A1UdDgQWBBTJqj8GSKamRNOQrLTu7TO/tFodujAfBgNVHSMEGDAWgBTJqj8GSKam
RNOQrLTu7TO/tFodujANBgkqhkiG9w0BAQsFAAOCAQEAuoD4QdhhqCY6jpZcLfgT
dC6w7GPXJjX/22LD5IHw3ceACP4VXbPrmhIRP96J8mhWpcMH+ENN+dwSNwv/NJbK
TI60qrLVCsf52Qjp7eTdyWGspiJw5txkjO45ch5SM3cB+0yeSTq/EIEeIuf15JT3
zLrcnzbAsoc6gKVoWbuxKVIrjczjSDYFEmRjVX9a39nBbVOmM1ZTWFGMNsRE6RLD
18Q50B+hMfF4bPvLBl2fr1i6uOYWJ6IN2ZfckgVnRdaqeTuKUAUCuGCjZxPA6cIK
1DvMYiqKyqEC1xMJdMBUkUd8ZGWP6aHy95IckqYqtEdVRr0UIIOGfc+lSyfFnJd3
MA==
-----END CERTIFICATE-----
crl_distribution_points           []
issuer_id                         00e91fd0-9909-4bb4-5b8b-23f0a4ad640b
issuer_name                       n/a
issuing_certificates              []
key_id                            n/a
leaf_not_after_behavior           err
manual_chain                      <nil>
ocsp_servers                      []
revocation_signature_algorithm    n/a
revoked                           false
usage                             crl-signing,issuing-certificates,ocsp-signing,read-only
```

Read issuer certificate

```
vault read /pkiintermediate/cert/ca

Key                        Value
---                        -----
certificate                -----BEGIN CERTIFICATE-----
MIIDsjCCApqgAwIBAgIUZ9D4A5cvT66wrvGcPfz1hWmlSJUwDQYJKoZIhvcNAQEL
BQAwHjEcMBoGA1UEAxMTQ2hlY2hpYS5uZXQgUm9vdCBDQTAeFw0yMzA1MDcxMzU4
MzVaFw0yODA1MDUxMzU5MDVaMC0xKzApBgNVBAMTIkNoZWNoaWEubmV0IEludGVy
bWVkaWF0ZSBBdXRob3JpdHkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDNKn1WO4p2dgEsFlXqLu3wQ86+aTERLoc3pSkzBAdaeRc1VQqN6NXow4Isfjap
D9SKu+oyVwneuBTjCIFdMvxgaN1kXtP24BFAWRp8odkyOya6vwWs25KsVu36JCK0
nf21Loe1R5YjVpkGrZrRzkknrAco4qcIGeG+3c3C4xR0mME0edst2K5x/Ggotsy8
+PsdRsb6dzVmFvpFY7vjCWUI0a4rj4jabgkRy6dHbcbs67QMn+vAPWrhd1sPQU4Z
S1gBkrDYqs3RHwayi2yIXGm9+Q8Zjyk1QEXcP1jMhSGaS0spWQ1nQx/P3FzLB9W/
XxNUSAlYTHRDQkv0DQy1a9hfAgMBAAGjgdgwgdUwDgYDVR0PAQH/BAQDAgEGMA8G
A1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFDIGWCj908iDqEFu1d3MZfUMtvcgMB8G
A1UdIwQYMBaAFMmqPwZIpqZE05CstO7tM7+0Wh26MD0GCCsGAQUFBwEBBDEwLzAt
BggrBgEFBQcwAoYhaHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraWNhL2NhMDMG
A1UdHwQsMCowKKAmoCSGImh0dHA6Ly8xMjcuMC4wLjE6ODIwMC92MS9wa2ljYS9j
cmwwDQYJKoZIhvcNAQELBQADggEBAEueU+ODuJ0207BXlWAW9p1u3pb+zzVodBgo
UBBgkbpgHCbvIQrUYXx/G748R6vRQ71jwGpVlVniqQ6hQ/mydOmwVXoujOyeHgVa
1lvxFS+EDineDh79A1MqJR8H5xWzSzIrgWudvYnKSwOZRSx+mEuLmUQyC3Q/1+5e
SNwF54/Wcq/DLTOEkDY5riIdStt9db/VT2grOzPHc6N6kx5g/FchwobzEIai7rxf
S2fNeUnQEq5w0/CHHNiMdrDYst++bECqNG4N2fCMe6XyF49j0ZTE1eBCv1Ycdr2k
lX0JPA2rEgVWBhrfGYnZZv8OCAeQ16NioqzVHqc2XIawpEP7b7A=
-----END CERTIFICATE-----
revocation_time            0
revocation_time_rfc3339    n/a


vault list /pkiintermediate/certs

Keys
----
cc:10:b5:24:d3:d9:e4:fc:46:d0:b9:a1:9b:c2:71:0d:83:2b:e3

vault read /pkiintermediate/cert/cc:10:b5:24:d3:d9:e4:fc:46:d0:b9:a1:9b:c2:71:0d:83:2b:e3

Key                        Value
---                        -----
certificate                -----BEGIN CERTIFICATE-----
MIIDZjCCAk6gAwIBAgIUAMwQtSTT2eT8RtC5oZvCcQ2DK+MwDQYJKoZIhvcNAQEL
BQAwLTErMCkGA1UEAxMiQ2hlY2hpYS5uZXQgSW50ZXJtZWRpYXRlIEF1dGhvcml0
eTAeFw0yMzA1MDcxMzU5NDZaFw0yNDA1MDYxNDAwMTZaMBsxGTAXBgNVBAMTEHRl
c3QuY2hlY2hpYS5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDs
8YfY7wACEHJ49ZDQLbwic0mcr8i+HckzuQNuWiYezJ+NS1poFMZ+xNj0w337dYkL
vs9mAy76r0ZEtb11SFO3z6iXtCJvJDUrR0J9XtWnaqH8R0DDkOyVnuQNgSV0edNL
GmdG3pFqMyUPI7vvK18dDuJj+bGTUYwO6k1ZvQnJYmJAuCVc3C+i8Y9g6rj1OpC/
oeEfm8aQZ61TRuaHY5OysWfPBJED/5It6TyW4WZXaO4kkG7lKOz7/C0DMBX/ycDz
Ppd2SfN5rtWMhAX+h8BxlHQl7bqaqY198WByBFQDOkwEdosUe95qNeOx7NECdi3S
o8/yHsIko3gffW1gPs7hAgMBAAGjgY8wgYwwDgYDVR0PAQH/BAQDAgOoMB0GA1Ud
JQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAdBgNVHQ4EFgQUm3Rs+sEnHIR3aR9B
J6qUPj+ifV0wHwYDVR0jBBgwFoAUMgZYKP3TyIOoQW7V3cxl9Qy29yAwGwYDVR0R
BBQwEoIQdGVzdC5jaGVjaGlhLm5ldDANBgkqhkiG9w0BAQsFAAOCAQEAtfrWOfNx
yTDjKzrFUygxBklP1ZQ56aiksTo4y+5E4ay9MubGU9JuQGl+uDM9DWcRPdfFus7Z
L90bEhnoUP8SwfSB4Li71K+d7PeUl137G1CTmevap10fZaKELqZGvdUC9Yqjm1vH
R+F3Ozjmod2X8LlO0H2U9MsTl+pay/NyMFdY50SRH4zngdsUgmilyMivLmXj2rZS
vswh3pKslL4pP4hT7LoWrdB5dQG/QRB6O4bUWnNKAJF4JpCmb6mbP3mMEzNftaBg
VnYUUApZGxdylTpJGdcwktE4qt2gW+MH9tK6UFqdf4Ph3yxFWREdlZ4nNr01imJq
Rt9OLD9kgRLXtQ==
-----END CERTIFICATE-----
revocation_time            0
revocation_time_rfc3339    n/a

vault read -format=json "/pkiintermediate/cert/cc:10:b5:24:d3:d9:e4:fc:46:d0:b9:a1:9b:c2:71:0d:83:2b:e3" | jq -r '.data.certificate'

-----BEGIN CERTIFICATE-----
MIIDZjCCAk6gAwIBAgIUAMwQtSTT2eT8RtC5oZvCcQ2DK+MwDQYJKoZIhvcNAQEL
BQAwLTErMCkGA1UEAxMiQ2hlY2hpYS5uZXQgSW50ZXJtZWRpYXRlIEF1dGhvcml0
eTAeFw0yMzA1MDcxMzU5NDZaFw0yNDA1MDYxNDAwMTZaMBsxGTAXBgNVBAMTEHRl
c3QuY2hlY2hpYS5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDs
8YfY7wACEHJ49ZDQLbwic0mcr8i+HckzuQNuWiYezJ+NS1poFMZ+xNj0w337dYkL
vs9mAy76r0ZEtb11SFO3z6iXtCJvJDUrR0J9XtWnaqH8R0DDkOyVnuQNgSV0edNL
GmdG3pFqMyUPI7vvK18dDuJj+bGTUYwO6k1ZvQnJYmJAuCVc3C+i8Y9g6rj1OpC/
oeEfm8aQZ61TRuaHY5OysWfPBJED/5It6TyW4WZXaO4kkG7lKOz7/C0DMBX/ycDz
Ppd2SfN5rtWMhAX+h8BxlHQl7bqaqY198WByBFQDOkwEdosUe95qNeOx7NECdi3S
o8/yHsIko3gffW1gPs7hAgMBAAGjgY8wgYwwDgYDVR0PAQH/BAQDAgOoMB0GA1Ud
JQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAdBgNVHQ4EFgQUm3Rs+sEnHIR3aR9B
J6qUPj+ifV0wHwYDVR0jBBgwFoAUMgZYKP3TyIOoQW7V3cxl9Qy29yAwGwYDVR0R
BBQwEoIQdGVzdC5jaGVjaGlhLm5ldDANBgkqhkiG9w0BAQsFAAOCAQEAtfrWOfNx
yTDjKzrFUygxBklP1ZQ56aiksTo4y+5E4ay9MubGU9JuQGl+uDM9DWcRPdfFus7Z
L90bEhnoUP8SwfSB4Li71K+d7PeUl137G1CTmevap10fZaKELqZGvdUC9Yqjm1vH
R+F3Ozjmod2X8LlO0H2U9MsTl+pay/NyMFdY50SRH4zngdsUgmilyMivLmXj2rZS
vswh3pKslL4pP4hT7LoWrdB5dQG/QRB6O4bUWnNKAJF4JpCmb6mbP3mMEzNftaBg
VnYUUApZGxdylTpJGdcwktE4qt2gW+MH9tK6UFqdf4Ph3yxFWREdlZ4nNr01imJq
Rt9OLD9kgRLXtQ==
-----END CERTIFICATE-----
```

# Revoke Cerfificate

https://developer.hashicorp.com/vault/api-docs/secret/pki#revoke-certificate

# Others

### Trust root CA

Mac
```
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" usage/pki/certs/ca/ca.crt
```
