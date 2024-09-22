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
                domainname = "talos.hel6.net",
                vcpu     = 4,
                memory   = 1024*8,
                diskpool = "libvirt_cephfs",
                disksize = 1024*1024*1024*100,
                network_interfaces = {
                "ens0" = { dhcp4 = false },
                },
                network_map = {
                "ens0" = "talos-ext",
                },
            },
            "w1" = {
                name     = "w1",
                domainname = "talos.hel6.net",
                vcpu     = 8,
                memory   = 1024*32,
                diskpool = "libvirt_cephfs",
                disksize = 1024*1024*1024*100,
                network_interfaces = {
                "ens0" = { dhcp4 = false },
                },
                network_map = {
                "ens0" = "talos-ext",
                },
            },
        },
    },
    }