Note
===

Architecture
- Storage Backend - durable
- barrier
- secret engine
  - kv engine
- autid device - log audit
- auth method
  - userpass
  - github
- client token
  - like session cookie
- secret
- server

# Consul

- consul-server
- consul-client
- consul-cli

Connect to consul-client (Gossip protocol, eventually consistent)
```
./consul info -http-addr 10.244.0.5:8500
```

Or to consul-server (Strong consistent)
```
./consul info -http-addr consul-consul-server:8500
```

Discover members
```
./consul members -http-addr 10.244.0.5:8500
```

DNS (to client then forward to server)
```
dig @10.244.0.5 -p 8600 consul-consul-server-0
```

Register Service (to client)
```
./consul agent -client 10.244.0.5 -dev -enable-script-checks -config-dir=./consul.d
```

# Consul Connect (Sidecar Envoy)

# Alpine

```
apk add bind-tools curl
```
