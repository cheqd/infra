output "seed_droplets" {
  value       = digitalocean_droplet.seed
  description = "Set of seed nodes running on DigitalOcean"
}

output "seed_volumes" {
  value       = digitalocean_volume.seed_volumes
  description = "Set of volumes used by seed nodes"
}

output "node_developer" {
  value       = digitalocean_firewall.node-developer
  description = "This firewall (managed by Cloud Provider) is used to restrict inbound/outbound developer(testing)traffic"
}

output "sentry_droplets" {
  value       = digitalocean_droplet.sentry
  description = "Set of sentry nodes running on DigitalOcean"
}

output "sentry_volumes" {
  value       = digitalocean_volume.sentry_volumes
  description = "Set of volumes used by sentry nodes"
}

output "node_public" {
  value       = digitalocean_firewall.node-public
  description = "This firewall (managed by Cloud Provider) is used to restrict inbound/outbound public traffic"
}

output "vpc" {
  value       = digitalocean_vpc.cheqd_network
  description = "Private Network for the entire fleet of services running on DigitalOcean"
}

output "node_restricted" {
  value       = digitalocean_firewall.node-restricted
  description = "This firewall is used to restrict inbound/outbound restricted(internal) traffic"
}

output "validator_droplets" {
  value       = digitalocean_droplet.validator
  description = "Set of Validator nodes running on DigitalOcean"
}

output "seed_floating_ip" {
  value       = digitalocean_floating_ip.seed
  description = "Set of DigitalOcean Floating IPs used by seed nodes"
}

output "sentry_floating_ip" {
  value       = digitalocean_floating_ip.sentry
  description = "Set of DigitalOcean Floating IPs used by sentry nodes"
}

output "validator_floating_ip" {
  value       = digitalocean_floating_ip.validator
  description = "Set of DigitalOcean Floating IPs used by validator nodes"
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
