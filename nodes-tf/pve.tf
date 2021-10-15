terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.1"
    }
  }
}

provider "proxmox" {
  # Conf
  pm_tls_insecure = true
  pm_api_url = "https://10.0.10.14:8006/api2/json"
  pm_password = var.pmpassword
  pm_user = "apiuser@pve"
  pm_otp = ""
}

resource "proxmox_vm_qemu" "pve_cloudinit" {
    name = "${var.hostname}${var.domainname}"
    desc = "A test for using terraform and cloudinit"
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = var.targetnode
    # The destination resource pool for the new VM
    pool = "Development"
    # The template name to clone this vm from
    clone = "terraform-ubuntu-vm"
    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = "2"
    sockets = "1"
    vcpus = "0"
    cpu = "host"
    memory = "512"
    scsihw = "virtio-scsi-pci"
    # Setup the disk. The id has to be unique
    disk {
        id = 0
        size = 32
        type = "virtio"
        storage = "local-lvm"
        storage_type = "lvm"
        iothread = true
    }
    # Setup the network interface and assign a vlan tag: 256
    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
        tag = 10
    }
    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=${var.pve_guest_ip}/24,gw=172.31.10.1"
    ciuser = var.ci_user
    cipassword = var.ci_password
    nameserver = "172.31.10.15" 
    searchdomain = "ipa.FQDN.io"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCWbiJsvCknsgWd5mbK5xvFmlNe/USJ8AB0b+IuL+J27Pr5QP76PaAt6ibaIMuIWrwOOgr0+5+Xqoulb1UUMqDuypGow6Rbw4SI50++tma4qZs3BFGTsVJrUv29Br7SiESSKH6dz30fb7+7+sqf3a4mS2kh4pCDLE4usV8Ge0RMcPC09ggk
EOF
}
