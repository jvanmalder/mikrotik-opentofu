include "provider" { path = find_in_parent_folders("provider.hcl") }
include "dhcp" { path = find_in_parent_folders("dhcp.hcl") }

terraform {
  source = "git::https://github.com/mirceanton/terraform-modules-routeros.git//modules/dhcp-server?ref=v0.2.1"
}

inputs = {
  interface   = "Guest"
  address     = "172.16.54.1/24"
  network     = "172.16.54.0/24"
  gateway     = "172.16.54.1"
  dhcp_pool   = ["172.16.54.100-172.16.54.199"]
  dns_servers = ["172.16.54.1"]
  domain      = "guest.chateau"

  static_leases = {}
}
