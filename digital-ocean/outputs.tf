output "seed_droplets" {
  value = digitalocean_droplet.seeds
}

output "seed_volumes" {
  value = digitalocean_volume.seed_volumes
}

output "seeds_firewall" {
  value = digitalocean_firewall.seeds
}

output "sentry_droplets" {
  value = digitalocean_droplet.sentries
}

output "sentry_volumes" {
  value = digitalocean_volume.sentry_volumes
}

output "sentries_firewall" {
  value = digitalocean_firewall.sentries
}

output "vpc" {
  value = digitalocean_vpc.cheqd_network
}
