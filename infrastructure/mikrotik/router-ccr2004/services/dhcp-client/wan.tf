terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
  }
}

import {
  to = routeros_ip_dhcp_client.wan
  id = "*1"
}

resource "routeros_ip_dhcp_client" "wan" {
  interface = "sfp-sfpplus1"
}
