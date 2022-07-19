output "seed_servers" {
  value       = hcloud_server.seed
  description = "Set of seed nodes running on Hetzner Cloud"
}

output "seed_volumes" {
  value       = hcloud_volume.seed
  description = "Set of volumes used by seed nodes"
}

output "seeds_firewall" {
  value       = hcloud_firewall.seed
  description = "This firewall is used to restrict inbound/outbound traffic for seed nodes"
}

output "sentry_servers" {
  value       = hcloud_server.sentry
  description = "Set of sentry nodes running on Hetzner Cloud"
}

output "sentry_volumes" {
  value       = hcloud_volume.sentry
  description = "Set of volumes used by sentry nodes"
}

output "sentries_firewall" {
  value       = hcloud_firewall.sentry
  description = "This firewall is used to restrict inbound/outbound traffic for sentry nodes"
}

output "vpc" {
  value       = hcloud_network.cheqd_network
  description = "Private Network for the entire fleet of services running on Hetzner Cloud"
}

output "validator_servers" {
  value       = hcloud_server.validator
  description = "Set of Validator nodes running on Hetzner Cloud"
}

output "seed_primary_ip" {
  value       = hcloud_primary_ip.seed
  description = "Set of Hetzner Primary IPs used by seed nodes"
}

output "sentry_primary_ip" {
  value       = hcloud_primary_ip.sentry
  description = "Set of Hetzner Primary IPs used by sentry nodes"
}

output "validator_primary_ip" {
  value       = hcloud_primary_ip.validator
  description = "Set of Hetzner Primary IPs used by validator nodes"
}

output "server_ips" {
  value = { for k, v in local.server_ips : k => {
    // This format is kept here to keep it consistent with other cloud providers.
    // We export from digital ocean as ipv4_address, so we do the same here
    ipv4_address = v.ip_address
    }
  }
  description = "This is a Set of all server IPs (Seeds, Sentries, and Validators) with key as node name (like seed1-ap-mainnet) and their value the IPv4 Address of the node. This is useful for doing easy DNS mapping using a for_each"
}

locals {
  server_ips = merge(
    hcloud_primary_ip.seed,
    hcloud_primary_ip.sentry,
    hcloud_primary_ip.validator,
  )
}
