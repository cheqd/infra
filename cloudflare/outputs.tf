output "cf_applications" {
  value = cloudflare_access_application.ssh
}

output "cloudflare_access_group" {
  value = cloudflare_access_group.ssh_group
}

output "cloudflare_access_policy" {
  value = cloudflare_access_policy.cheqd
}

output "cloudflare_device_posture_rule" {
  value = cloudflare_device_posture_rule.default
}

output "cloudflare_zone" {
	value = data.cloudflare_zone.cheqd
}
