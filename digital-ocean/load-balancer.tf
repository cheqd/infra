resource "digitalocean_loadbalancer" "cheqd" {
  name     = "cheqd-${var.network}-lb"
  region   = var.do_region
  vpc_uuid = digitalocean_vpc.cheqd_network.id

  algorithm = var.do_lb_algorithm
  size      = var.do_lb_size

  dynamic "forwarding_rule" {
    for_each = var.do_lb_config

    content {
      entry_port      = forwarding_rule.value.entry_port
      entry_protocol  = forwarding_rule.value.entry_protocol
      target_port     = forwarding_rule.value.target_port
      target_protocol = forwarding_rule.value.target_protocol

      certificate_name = parseint(forwarding_rule.value.entry_port, 10) == 443 ? digitalocean_certificate.cheqd.name : null
    }
  }

  sticky_sessions {
    type = "none"
  }

  redirect_http_to_https = true
  enable_backend_keepalive = false

  healthcheck {
    port     = var.do_health_check_port
    protocol = var.do_health_check_protocol
  }

  droplet_ids = concat(local.seed_droplet_ids, local.sentry_droplet_ids)
}

resource "digitalocean_certificate" "cheqd" {
  name              = "${var.network}-cf-cert"
  type              = "custom"
  private_key       = var.do_lb_priv_key
  leaf_certificate  = var.do_lb_leaf_cert
  certificate_chain = var.do_lb_certificate_chain
}

locals {
  seed_droplet_ids   = [for droplet in digitalocean_droplet.seeds : droplet.id]
  sentry_droplet_ids = [for droplet in digitalocean_droplet.sentries : droplet.id]
}
