path "kv/data/boundary/config" {
  capabilities = ["read"]
}

path "pki/issue/boundary.consul" {
  capabilities = ["update"]
}

path "pki/issue/service.consul" {
  capabilities = ["update"]
}

path "transit/encrypt/boundary-worker-auth" {
  capabilities = ["update"]
}

path "transit/encrypt/boundary-global-root" {
  capabilities = ["update"]
}

path "transit/encrypt/boundary-recovery" {
  capabilities = ["update"]
}

path "transit/decrypt/boundary-worker-auth" {
  capabilities = ["update"]
}

path "transit/decrypt/boundary-global-root" {
  capabilities = ["update"]
}

path "transit/decrypt/boundary-recovery" {
  capabilities = ["update"]
}
