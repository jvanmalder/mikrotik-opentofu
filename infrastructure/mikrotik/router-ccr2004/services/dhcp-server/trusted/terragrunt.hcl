include "provider" { path = find_in_parent_folders("provider.hcl") }
include "dhcp" { path = find_in_parent_folders("dhcp.hcl") }

terraform {
  source = "git::https://github.com/mirceanton/terraform-modules-routeros.git//modules/dhcp-server?ref=v0.2.1"
}

inputs = {
  interface   = "Trusted"
  address     = "192.168.54.1/24"
  network     = "192.168.54.0/24"
  gateway     = "192.168.54.1"
  dhcp_pool   = ["192.168.54.100-192.168.54.199"]
  dns_servers = ["192.168.54.1"]
  domain      = "trust.chateau"

  static_leases = {
    "192.168.54.2"  = { name = "wifi-bureau", mac = "1C:0B:8B:B4:3A:95" }
    "192.168.54.99"  = { name = "nas", mac = "C8:FF:BF:06:67:9B" }
  }
}
