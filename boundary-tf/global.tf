resource "boundary_scope" "global_infra_scope" {
  global_scope = true
  description  = "Global Scope"
  scope_id     = "global"
  name         = "global"
}

resource "boundary_scope" "infra_scope" {
  name                     = "Infra"
  description              = "Scope for all infra"
  scope_id                 = boundary_scope.global_infra_scope.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "core_infra" {
  name                   = "Dev Infrastructure"
  description            = "Dev Project"
  scope_id               = boundary_scope.infra_scope.id
  auto_create_admin_role = true
}

resource "boundary_auth_method_oidc" "netsso" {
  name                   = ""
  description            = "keycloak"
  scope_id               = boundary_scope.global_infra_scope.id
  api_url_prefix         = ""      
  signing_algorithms     = ["RS256"]
  callback_url           = ""
  client_id              = "dev-boundary-client-oidc"
  client_secret          = ""
  issuer                 = ""
  is_primary_for_scope   = true
}

