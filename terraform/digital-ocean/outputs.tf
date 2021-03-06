output "seed_droplets" {
  value       = digitalocean_droplet.seed
  description = "Set of seed nodes running on Digital Ocean"
}

output "seed_volumes" {
  value       = digitalocean_volume.seed_volumes
  description = "Set of volumes used by seed nodes"
}

output "seed_firewall" {
  value       = digitalocean_firewall.seed
  description = "This firewall (managed by Cloud Provider) is used to restrict inbound/outbound traffic for seed nodes"
}

output "sentry_droplets" {
  value       = digitalocean_droplet.sentry
  description = "Set of sentry nodes running on Digital Ocean"
}

output "sentry_volumes" {
  value       = digitalocean_volume.sentry_volumes
  description = "Set of volumes used by sentry nodes"
}

output "sentry_firewall" {
  value       = digitalocean_firewall.sentry
  description = "This firewall (managed by Cloud Provider) is used to restrict inbound/outbound traffic for sentry nodes"
}

output "vpc" {
  value       = digitalocean_vpc.cheqd_network
  description = "Private Network for the entire fleet of services running on Digital Ocean"
}

output "validator_firewall" {
  value       = digitalocean_firewall.validator
  description = "This firewall is used to restrict inbound/outbound traffic for validator nodes"
}

output "validator_droplets" {
  value       = digitalocean_droplet.validator
  description = "Set of Validator nodes running on Digital Ocean"
}

output "seed_floating_ip" {
  value       = digitalocean_floating_ip.seed
  description = "Set of Digital Ocean Floating IPs used by seed nodes"
}

output "sentry_floating_ip" {
  value       = digitalocean_floating_ip.sentry
  description = "Set of Digital Ocean Floating IPs used by sentry nodes"
}

output "validator_floating_ip" {
  value       = digitalocean_floating_ip.validator
  description = "Set of Digital Ocean Floating IPs used by validator nodes"
}

output "server_ips" {
  value = { for k, v in local.server_ips : k => {
    ipv4_address = v.ip_address
    }
  }
  description = "This is a Set of all server IPs (Seeds, Sentries, and Validators) with key as node name (like seed1-ap-mainnet) and their value the IPv4 Address of the node. This is useful for DNS mapping using a for_each"
}

locals {
  server_ips = merge(
    digitalocean_floating_ip.seed,
    digitalocean_floating_ip.sentry,
    digitalocean_floating_ip.validator,
  )
}
