resource "vault_mount" "ssh" {
  path        = "ssh"
  type        = "ssh"
  description = "SSH key signer mount"
}

resource "vault_ssh_secret_backend_ca" "ssh_ca" {
  generate_signing_key=true
  backend = vault_mount.ssh.path
}

resource "vault_ssh_secret_backend_role" "ssh-pi-role" {
    name          = "ssh-pi-role"
    backend       = vault_mount.ssh.path
    default_extensions = {
      "permit-pty" = ""
    }
    allowed_extensions = "permit-pty,permit-port-forwarding"
    key_type      = "ca"
    default_user  = "pi"
    allow_user_certificates = true
    allowed_users = "pi"
    ttl = "30"
}

data "template_file" "vault_ssh_policy_template" {
  template = file("${path.module}/policies/vault-ssh-policy.hcl")
}

resource "vault_policy" "vault_ssh_policy" {
  name = "vault-ssh"
  policy = data.template_file.vault_ssh_policy_template.rendered
}