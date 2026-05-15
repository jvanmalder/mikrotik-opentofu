include "provider" {
  path   = "./provider.hcl"
  expose = true
}

locals {
  mikrotik_globals = read_terragrunt_config(find_in_parent_folders("globals.hcl")).locals
}

terraform {
  source = "git::https://github.com/jvanmalder/opentofu-modules-routeros.git//modules/base?ref=47767f4"
}
inputs = {
  hostname                 = upper(split("-", basename(get_terragrunt_dir()))[1])
  certificate_common_name  = include.provider.locals.mikrotik_hostname
  certificate_country      = local.mikrotik_globals.certificate_country
  certificate_locality     = local.mikrotik_globals.certificate_locality
  certificate_organization = local.mikrotik_globals.certificate_organization
  certificate_unit         = local.mikrotik_globals.certificate_unit
  disable_ipv6             = local.mikrotik_globals.disable_ipv6
  timezone                 = local.mikrotik_globals.timezone

  mac_server_interfaces = local.mikrotik_globals.mac_server_interfaces

  vlans = local.mikrotik_globals.vlans
  interfaces = {
    "sfp-sfpplus1" = { comment = "Chateau Uplink", bridge_port = false }
    "sfp-sfpplus2" = {}
    "sfp-sfpplus3" = {}
    "sfp-sfpplus4" = {}
    "sfp-sfpplus5" = {}
    "sfp-sfpplus6" = {}
    "sfp-sfpplus7" = {}
    "sfp-sfpplus8" = { comment = "NAS 10g 1", bridge_port = false, l2mtu = 9216, mtu = 9000 }
    "sfp-sfpplus9" = { comment = "NAS 10g 2", bridge_port = false, l2mtu = 9216, mtu = 9000 }
    "sfp-sfpplus10" = { comment = "WiFi", untagged = local.mikrotik_globals.vlans.Trusted.name, tagged = [local.mikrotik_globals.vlans.IoT.name] }
    "sfp-sfpplus11" = { comment = "LAN" }
    "sfp-sfpplus12" = { comment = "IoT", tagged = [local.mikrotik_globals.vlans.IoT.name, local.mikrotik_globals.vlans.Management.name] }
    "sfp28-1"       = {}
    "sfp28-2"       = {}
    "ether1" = { comment = "Access Point", untagged = local.mikrotik_globals.vlans.Management.name }
  }
  bond_interfaces = {
    "bond1" = {
      comment = "NAS", mtu = 9000
      slaves  = ["sfp-sfpplus8", "sfp-sfpplus9"]
      untagged  = local.mikrotik_globals.vlans.Trusted.name
    }
  }
}
