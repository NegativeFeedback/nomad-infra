provider "vault" {
  address = "https://active.vault.service.consul:8200"
  skip_tls_verify = "true"
}

resource "vault_token_auth_backend_role" "nomad_cluster_role" {
  role_name              = "nomad-cluster"
  disallowed_policies    = ["nomad-server"]
  orphan                 = true
  token_period           = "259200"
  renewable              = true
  token_explicit_max_ttl = "0"
}

data "vault_generic_secret" "vault_openid_client" {
  path = "kv/keycloak/realms/vault"
}
