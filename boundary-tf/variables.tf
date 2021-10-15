variable "users" {
  type    = set(string)
  default = [
    "",
  ]
}

variable "raspberry_pi_ips" {
  type    = set(string)
  default = [
    "192.168.1.200",
    "192.168.1.201",
    "192.168.1.202",
    "192.168.1.203",
    "192.168.1.204",
  ]
}

variable "vault" {
  type    = set(string)
  default = [
    "active.vault.service.consul"
  ]
}

variable "nomad" {
  type    = set(string)
  default = [
    "nomad.service.consul"
  ]
}

variable "prdp" {
  type    = set(string)
  default = [
    "10.0.50.38"
  ]
}

variable "postgres" {
  type    = set(string)
  default = [
    "postgres.service.consul"
  ]
}
