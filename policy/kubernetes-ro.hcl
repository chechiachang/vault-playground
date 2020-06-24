# Configure kubernetes
path "secret/data/myapp/*" {
    capabilities = ["read", "list"]
}
