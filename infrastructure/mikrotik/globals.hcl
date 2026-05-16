locals {
  timezone       = "Europe/Brussels"

  # ===============================================================================================
  # Certificate Defaults
  # ===============================================================================================
  certificate_country      = "BE"
  certificate_locality     = "BRU"
  certificate_organization = "CHATEAU"
  certificate_unit         = "HOME"

  # ===============================================================================================
  # Device Defaults
  # ===============================================================================================
  disable_ipv6          = true
  mac_server_interfaces = "all"

  # ===============================================================================================
  # VLAN Definitions
  # ===============================================================================================
  all_vlans                = keys(local.vlans)
  all_but_management_vlans = [for name, vlan in local.vlans : vlan.name if name != "Management"]
  vlans = {
    IoT   = { name = "IoT", vlan_id = 10 }
    Management = { name = "Management", vlan_id = 20 }
    Trusted = { name = "Trusted", vlan_id = 30 }
    Guest = { name = "Guest", vlan_id = 40 }
  }
}
