resource "vault_mount" "pki" {
  path        = "pki"
  type        = "pki"
  description = "PKI root CA mount"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds = 788400000
}

resource "vault_pki_secret_backend_root_cert" "vault_root_ca" {
  depends_on = [ vault_mount.pki ]
  backend = vault_mount.pki.path
  type = "internal"
  common_name = "Vault Root CA"
  ttl = "788400000"
  format = "pem"
  private_key_format = "der"
  key_type = "rsa"
  key_bits = 4096
  exclude_cn_from_sans = true
}

resource "vault_pki_secret_backend_role" "boundary-pki-role" {
  backend = vault_mount.pki.path
  name    = "boundary.consul"
  allowed_domains=["gddnet.io", "service.consul", "localhost", "consul"]
  allow_subdomains=true
  allow_ip_sans=true
  generate_lease=true
  key_usage = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment"
  ]
  max_ttl="2592000"
}

resource "vault_pki_secret_backend_role" "nomad-pki-role" {
  backend = vault_mount.pki.path
  name    = "service.consul"
  allowed_domains=["service.consul", "nomad", "localhost"]
  allow_subdomains=true
  allow_ip_sans=true
  generate_lease=true
  key_usage = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment"
  ]
  max_ttl="2592000"
}

resource "vault_generic_secret" "root_ca_certificate" {
  path = "kv/vault_root_ca"

  data_json = <<EOT
{
  "ca":   "${base64encode(vault_pki_secret_backend_root_cert.vault_root_ca.issuing_ca)}"
}
EOT
}
