# Output results to console
output "ips" {
  value = libvirt_domain.vds.network_interface[*].addresses
}
