resource "digitalocean_loadbalancer" "cheqd" {
  name   = "cheqd-${var.network}-lb"
  region = var.do_region


  dynamic "forwarding_rule" {
    for_each = var.do_lb_config

    entry_port      = forwarding_rule.value.entry_port
    entry_protocol  = forwarding_rule.value.entry_protocol
    target_port     = forwarding_rule.value.target_port
    target_protocol = forwarding_rule.value.target_protocol
  }

  dynamic "healthcheck" {
    for_each = var.do_lb_config

    port     = healthcheck.value.health_check_port
    protocol = lookup(healthcheck.value, "health_check_protocol", "tcp")
  }

  droplet_ids = concat(local.seed_droplet_ids, local.sentry_droplet_ids)
}

locals {
  seed_droplet_ids   = [for droplet in digitalocean_droplet.seeds : droplet.id]
  sentry_droplet_ids = [for droplet in digitalocean_droplet.sentries : droplet.id]
}
