resource "vault_mount" "transit" {
  path                      = "transit"
  type                      = "transit"
  description               = "Transit encryption mount for Boundary"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "boundary-root" {
  backend = vault_mount.transit.path
  name    = "boundary-global-root"
}

resource "vault_transit_secret_backend_key" "boundary-worker-auth" {
  backend = vault_mount.transit.path
  name    = "boundary-worker-auth"
}

resource "vault_transit_secret_backend_key" "boundary-recovery" {
  backend = vault_mount.transit.path
  name    = "boundary-recovery"
}