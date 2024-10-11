** About the terraform and modules **

Many thanks go out to Duncan Mac-Vicar P. for creating the awesome https://github.com/dmacvicar/terraform-provider-libvirt I use.

Using count in terraform can be problematic when taking out resources from the set at a later date

Resource id and references can be lost.

My (kind of unothodox) solution (as I've been told) is to create a "structure" and have terraform iterate over the items using modules and foreach.

See terraform.tfvars for the structure.

    hosts = {
        "local" = {
            "networks" = {
                "talos-ext" = { "mode" = "bridge", "bridge" = "br0", "autostart" = true },
            },
            "vds" = {
                "c1" = {
                    name     = "c1",
                    domainname = "talos.examle.com",
                    vcpu     = 4,
                    memory   = 1024*8,
                    diskpool = "libvirt_cephfs",
                    disksize = 1024*1024*1024*100,
                    network_interfaces = {
                    "ens0" = { dhcp4 = false, mac = "de:ad:be:ef:13:37" },
                    },
                    network_map = {
                    "ens0" = "talos-ext",
                    },
                },
                "w1" = {
                    name     = "w1",
                    domainname = "talos.example.com",
                    vcpu     = 8,
                    memory   = 1024*32,
                    diskpool = "libvirt_cephfs",
                    disksize = 1024*1024*1024*100,
                    network_interfaces = {
                    "ens0" = { dhcp4 = false, mac = "de:ad:be:ef:13:38" },
                    },
                    network_map = {
                    "ens0" = "talos-ext",
                    },
                },
            },
        },
    }

