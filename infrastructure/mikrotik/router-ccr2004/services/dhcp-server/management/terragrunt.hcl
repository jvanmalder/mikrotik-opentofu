include "provider" { path = find_in_parent_folders("provider.hcl") }
include "dhcp" { path = find_in_parent_folders("dhcp.hcl") }

terraform {
  source = "git::https://github.com/mirceanton/terraform-modules-routeros.git//modules/dhcp-server?ref=v0.2.1"
}

inputs = {
  interface   = "Management"
  address     = "10.0.0.1/24"
  network     = "10.0.0.0/24"
  gateway     = "10.0.0.1"
  dhcp_pool   = ["10.0.0.195-10.0.0.199"]
  dns_servers = ["10.0.0.1"]
  domain      = "mgmt.chateau"

  static_leases = {
    "10.0.0.2"  = { name = "mikrotik-css610", mac = "F4:1E:57:C4:BB:EC" }
  }
}
