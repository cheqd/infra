output "seed_droplets" {
  value = digitalocean_droplet.seed
}

output "seed_volumes" {
  value = digitalocean_volume.seed_volumes
}

output "seed_firewall" {
  value = digitalocean_firewall.seed
}

output "sentry_droplets" {
  value = digitalocean_droplet.sentry
}

output "sentry_volumes" {
  value = digitalocean_volume.sentry_volumes
}

output "sentry_firewall" {
  value = digitalocean_firewall.sentry
}

output "vpc" {
  value = digitalocean_vpc.cheqd_network
}

output "validator_firewall" {
  value = digitalocean_firewall.validator
}

output "validator_droplets" {
  value = digitalocean_droplet.validator
}

output "seed_floating_ip" {
  value = digitalocean_floating_ip.seed
}

output "sentry_floating_ip" {
  value = digitalocean_floating_ip.sentry
}

output "validator_floating_ip" {
  value = digitalocean_floating_ip.validator
}

output "server_ips" {
  value = { for k, v in local.server_ips : k => {
    ipv4_address = v.ip_address
    }
  }
}

locals {
  server_ips = merge(
    digitalocean_floating_ip.seed,
    digitalocean_floating_ip.sentry,
    digitalocean_floating_ip.validator,
  )
}
