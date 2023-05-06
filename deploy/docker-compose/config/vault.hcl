ui            = true
disable_mlock = true

storage "consul" {
  address = "consul_1:8500"
  path    = "vault/"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = "true"
  #tls_cert_file = "/path/to/full-chain.pem"
  #tls_key_file  = "/path/to/private-key.pem"
}

#telemetry {
#  statsite_address = "0.0.0.0:8125"
#  disable_hostname = true
#}
