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
