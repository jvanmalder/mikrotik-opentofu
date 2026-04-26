include "provider" { path = find_in_parent_folders("provider.hcl") }

terraform {
  source = "git::https://github.com/jvanmalder/opentofu-modules-routeros.git//modules/dns-server?ref=47767f4"
}

inputs = {
  upstream_dns = ["86.54.11.13", "86.54.11.213"]
}
