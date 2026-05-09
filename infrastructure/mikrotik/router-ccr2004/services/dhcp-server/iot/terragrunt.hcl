include "provider" { path = find_in_parent_folders("provider.hcl") }
include "dhcp" { path = find_in_parent_folders("dhcp.hcl") }

terraform {
  source = "git::https://github.com/mirceanton/terraform-modules-routeros.git//modules/dhcp-server?ref=v0.2.1"
}

inputs = {
  interface   = "IoT"
  address     = "192.168.10.1/24"
  network     = "192.168.10.0/24"
  gateway     = "192.168.10.1"
  dhcp_pool   = ["192.168.10.100-192.168.10.199"]
  dns_servers = ["192.168.10.1"]

  static_leases = {
    "192.168.10.3"  = { name = "home-assistant", mac = "B8:27:EB:EA:4C:46" }
    "192.168.10.4"  = { name = "kiosk", mac = "E4:5F:01:05:3F:50" }
    "192.168.10.5"  = { name = "laadpaal", mac = "C8:DF:84:97:D4:69" }
  }
}
