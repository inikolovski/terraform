variable "hosts" {
  default = {
    "kvm1" = {
      networks = {
        "internal" = { },
        "external" = { },
      },
      "vds" = {
        "srv1" = {
          name = "srv1",
          vcpu     = 1,
          memory   = "${1024 * 1}",
          diskpool = "default",
          disksize = "${1024*1024*1024*10}",
          network_interfaces = {
            "internal" = {  },
            "external" = {  },
          },
        },
      },
    },
  }
}

variable "source_host" {
  type = string
  default = "127.0.0.1"
}