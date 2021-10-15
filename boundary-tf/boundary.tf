
resource "boundary_host_catalog" "raspberry_pis" {
  name        = "raspberry_pis"
  description = "Raspberry Pi host catalog"
  type        = "static"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_host" "raspberry_pis" {
  for_each        = var.raspberry_pi_ips
  type            = "static"
  name            = "raspberry_pi_${each.value}"
  description     = "Raspberry Pi"
  address         = each.key
  host_catalog_id = boundary_host_catalog.raspberry_pis.id
}

resource "boundary_host_set" "raspberry_pi" {
  type            = "static"
  name            = "raspberry_pi"
  description     = "Host set for Raspberry Pis"
  host_catalog_id = boundary_host_catalog.raspberry_pis.id
  host_ids        = [for host in boundary_host.raspberry_pis : host.id]
}

resource "boundary_host_catalog" "vault" {
  name        = "vault"
  description = "Vault host catalog"
  type        = "static"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_host" "vault" {
  for_each        = var.vault
  type            = "static"
  name            = each.value
  description     = "HashiCorp Vault"
  address         = each.key
  host_catalog_id = boundary_host_catalog.vault.id
}

resource "boundary_host_set" "vault" {
  type            = "static"
  name            = "vault"
  description     = "Host set for Vault"
  host_catalog_id = boundary_host_catalog.vault.id
  host_ids        = [for host in boundary_host.vault : host.id]
}

resource "boundary_host_catalog" "nomad" {
  name        = "nomad"
  description = "Nomad host catalog"
  type        = "static"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_host" "nomad" {
  for_each        = var.nomad
  type            = "static"
  name            = each.value
  description     = "HashiCorp Nomad"
  address         = each.key
  host_catalog_id = boundary_host_catalog.nomad.id
}

resource "boundary_host_set" "nomad" {
  type            = "static"
  name            = "nomad"
  description     = "Host set for Nomad"
  host_catalog_id = boundary_host_catalog.nomad.id
  host_ids        = [for host in boundary_host.nomad : host.id]
}

resource "boundary_target" "raspberry_pi_ssh" {
  type         = "tcp"
  name         = "Raspberry Pi"
  description  = "Backend SSH target"
  scope_id     = boundary_scope.core_infra.id
  default_port = "22"

  host_set_ids = [
    boundary_host_set.raspberry_pi.id
  ]
}

resource "boundary_target" "vault_api" {
  type         = "tcp"
  name         = "Vault API"
  description  = "Backend Vault target"
  scope_id     = boundary_scope.core_infra.id
  default_port = "8200"
  session_connection_limit = 2
  host_set_ids = [
    boundary_host_set.vault.id
  ]
}

resource "boundary_target" "nomad" {
  type         = "tcp"
  name         = "Nomad API"
  description  = "Backend Nomad target"
  scope_id     = boundary_scope.core_infra.id
  default_port = "4646"
  session_connection_limit = 2
  host_set_ids = [
    boundary_host_set.nomad.id
  ]
}
######
resource "boundary_host_catalog" "prdp" {
  name        = "prdp"
  description = "prdp host catalog"
  type        = "static"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_host" "prdp" {
  for_each        = var.prdp
  type            = "static"
  name            = each.value
  description     = "HashiCorp prdp"
  address         = each.key
  host_catalog_id = boundary_host_catalog.prdp.id
}

resource "boundary_host_set" "prdp" {
  type            = "static"
  name            = "prdp"
  description     = "Host set for prdp"
  host_catalog_id = boundary_host_catalog.prdp.id
  host_ids        = [for host in boundary_host.prdp : host.id]
}

resource "boundary_target" "prdp_api" {
  type         = "tcp"
  name         = "prdp API"
  description  = "Backend prdp target"
  scope_id     = boundary_scope.core_infra.id
  default_port = "3389"
  session_connection_limit = 1
  host_set_ids = [
    boundary_host_set.prdp.id
  ]
}
######

