terraform {
  required_version = ">= 1.1.2"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  alias = "local"
  uri   = "qemu+ssh://root@127.0.0.1/system?keyfile=/root/.ssh/id_ed25519_virsh"
}

module "deploy_local" {
  source = "./modules/libvirt"
  providers = {
    libvirt = libvirt.local
  }
  hosts=var.hosts["local"]
  source_host="127.0.0.1"
}

