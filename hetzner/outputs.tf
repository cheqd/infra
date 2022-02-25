output "seed_servers" {
  value = hcloud_server.seed
}

output "seed_volumes" {
  value = hcloud_volume.seed
}

output "seeds_firewall" {
  value = hcloud_firewall.seed
}

output "sentry_servers" {
  value = hcloud_server.sentry
}

output "sentry_volumes" {
  value = hcloud_volume.sentry
}

output "sentries_firewall" {
  value = hcloud_firewall.sentry
}

output "vpc" {
  value = hcloud_network.cheqd_network
}

output "validator_servers" {
  value = hcloud_server.validator
}
