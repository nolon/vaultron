# Allow listing and reading of surfboards
path "secret/roger/*" {
      capabilities = ["list", "create", "read", "update", "delete"]
}

# UI-specific Policies for ease of navigation

path "vaultron_kv/data/surfboard/*" {
  capabilities = ["create", "read", "update", "delete"]
}
path "vaultron_kv/metadata/surfboard/*" {
  capabilities = ["list"]
}
path "vaultron_kv/metadata/" {
  capabilities = ["list"]
}
path "sys/mounts" {
  capabilities = ["read", "list"]
}

# Testing...

path "vaultron_kv" {
  capabilities = ["list"]
}
path "vaultron_kv/surfboard" {
  capabilities = ["list"]
}
