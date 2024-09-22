terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

resource "libvirt_network" "networks" {
  for_each = var.hosts["networks"]
  name = each.key
  mode = each.value.mode
  bridge = each.value.bridge
  autostart = each.value.autostart
}

module "vds" {
  for_each = var.hosts["vds"]
  source = "../libvirt_vds"
  host = each.value
  source_host = var.source_host
}
