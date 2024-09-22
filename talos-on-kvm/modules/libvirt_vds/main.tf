terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}


# Create disk for each host
# diskpool can be created in the module libvirt. Or manually on the host.
resource "libvirt_volume" "qcow2_volume" {
  name           = "${var.host.name}-${replace(var.host.domainname,".","-")}.qcow2"
  pool           = var.host.diskpool
  format         = "qcow2"
  size           = var.host.disksize
}

# Define KVM-Guest/Domain
resource "libvirt_domain" "vds" {
  name   = "${var.host.name}-${replace(var.host.domainname,".","-")}"
  memory = var.host.memory
  vcpu   = var.host.vcpu
  autostart = true
  machine = "q35"

  # I like passthrough mode. Migrations might suffer. But I dont care about it in my sandbox.
  cpu {
    mode = "host-passthrough"
  }

  dynamic "network_interface" {
    for_each = var.host.network_interfaces
    content {
      hostname       = var.host.name
      network_name   = lookup(var.host.network_map,"${network_interface.key}", "talos-ext")
      wait_for_lease = network_interface.value["dhcp4"]
    }
  }

  graphics {
    listen_address = var.source_host
    type = "vnc"
    listen_type = "address"
    autoport = "true"
  }

  console {
    source_host = var.source_host
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  console {
    source_host = var.source_host
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  boot_device {
    dev = [ "hd", "cdrom"]
  }

  disk {
    volume_id = element(libvirt_volume.qcow2_volume.*.id, 1 )
  }

  ## talos iso cdrom mount, should be on host. Alternatively use url.
  disk {
    file = "/data/libvirt-ceph/iso/metal-amd64.iso"
  }

  # use the xslt transform on the domain xml to make the created guest q35 and pcie capable
  # keep in mind I've added numad to the kvm host. Setting the cpu placement to auto in the xslt.
  xml {
    xslt = file("${path.module}/ide2sata.xslt")
  }
}

