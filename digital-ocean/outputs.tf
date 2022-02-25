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
