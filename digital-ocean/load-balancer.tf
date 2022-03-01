resource "digitalocean_loadbalancer" "rpc_lb" {
  name     = "cheqd-${var.network}-rpc-lb"
  region   = var.do_region
  vpc_uuid = digitalocean_vpc.cheqd_network.id

  algorithm = var.do_rpc_lb_algorithm
  size      = var.do_rpc_lb_size

  dynamic "forwarding_rule" {
    for_each = var.do_rpc_lb_config

    content {
      entry_port      = forwarding_rule.value.entry_port
      entry_protocol  = forwarding_rule.value.entry_protocol
      target_port     = forwarding_rule.value.target_port
      target_protocol = forwarding_rule.value.target_protocol

      certificate_name = parseint(forwarding_rule.value.entry_port, 10) == 443 ? digitalocean_certificate.wildcard.name : null
    }
  }

  sticky_sessions {
    type = "none"
  }

  redirect_http_to_https   = true
  enable_backend_keepalive = false

  healthcheck {
    port     = var.do_rpc_health_check_port
    protocol = var.do_rpc_health_check_protocol
  }

  droplet_ids = concat(local.seed_droplet_ids, local.sentry_droplet_ids)
}

resource "digitalocean_loadbalancer" "api_lb" {
  name     = "cheqd-${var.network}-api-lb"
  region   = var.do_region
  vpc_uuid = digitalocean_vpc.cheqd_network.id

  algorithm = var.do_api_lb_algorithm
  size      = var.do_api_lb_size

  dynamic "forwarding_rule" {
    for_each = var.do_api_lb_config

    content {
      entry_port      = forwarding_rule.value.entry_port
      entry_protocol  = forwarding_rule.value.entry_protocol
      target_port     = forwarding_rule.value.target_port
      target_protocol = forwarding_rule.value.target_protocol

      certificate_name = parseint(forwarding_rule.value.entry_port, 10) == 443 ? digitalocean_certificate.wildcard.name : null
    }
  }

  sticky_sessions {
    type = "none"
  }

  redirect_http_to_https   = true
  enable_backend_keepalive = false

  healthcheck {
    port     = var.do_api_health_check_port
    protocol = var.do_api_health_check_protocol
  }

  droplet_ids = concat(local.seed_droplet_ids, local.sentry_droplet_ids)
}

resource "digitalocean_certificate" "wildcard" {
  name              = "${var.network}-wildcard-cf-cert"
  type              = "custom"
  private_key       = data.vault_generic_secret.do_lb_wildcard.data["priv_key"]
  leaf_certificate  = data.vault_generic_secret.do_lb_wildcard.data["csr"]
  certificate_chain = data.vault_generic_secret.cf_root_ca.data["cert"]
}

locals {
  seed_droplet_ids   = [for droplet in digitalocean_droplet.seed : droplet.id]
  sentry_droplet_ids = [for droplet in digitalocean_droplet.sentry : droplet.id]
}
