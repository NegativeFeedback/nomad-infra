data "template_file" "nomad_ddns_policy_template" {
  template = file("${path.module}/policies/nomad-ddns-policy.hcl")
}

resource "vault_policy" "nomad_ddns_policy" {
  name = "nomad-ddns-policy"
  policy = data.template_file.nomad_ddns_policy_template.rendered
}

data "template_file" "nomad_traefik_policy_template" {
  template = file("${path.module}/policies/nomad-traefik-policy.hcl")
}

resource "vault_policy" "nomad_traefik_policy" {
  name = "nomad-traefik-policy"
  policy = data.template_file.nomad_traefik_policy_template.rendered
}

data "template_file" "nomad_nats_policy_template" {
  template = file("${path.module}/policies/nomad-nats-policy.hcl")
}

resource "vault_policy" "nomad_nats_policy" {
  name = "nomad-nats-policy"
  policy = data.template_file.nomad_nats_policy_template.rendered
}


data "template_file" "nomad_server_policy_template" {
  template = file("${path.module}/policies/nomad-server-policy.hcl")
}

resource "vault_policy" "nomad_server_policy" {
  name = "nomad-server"
  policy = data.template_file.nomad_server_policy_template.rendered
}

data "template_file" "nomad_boundary_policy_template" {
  template = file("${path.module}/policies/nomad-boundary-policy.hcl")
}

resource "vault_policy" "nomad_boundary_policy" {
  name = "nomad-boundary"
  policy = data.template_file.nomad_boundary_policy_template.rendered
}

resource "vault_policy" "boundary_controller_policy" {
  name = "boundary_controller"
  policy = data.template_file.nomad_boundary_policy_template.rendered
}