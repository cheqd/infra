# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer Certificates
# ----------------------------------------------------------------------------------------------------------------------
data "digitalocean_certificate" "cheqd" {
  name = "${var.network}-certificate"
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer - RPC
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_loadbalancer" "rpc_lb" {
  name     = "${var.network}-rpc-lb"
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

      certificate_name = parseint(forwarding_rule.value.entry_port, 10) == 443 ? data.digitalocean_certificate.cheqd.name : null
    }
  }

  sticky_sessions {
    type = "none"
  }

  redirect_http_to_https = true

  healthcheck {
    protocol = var.do_rpc_health_check_protocol
    port     = var.do_rpc_health_check_port
    path     = "/status"
  }

  droplet_tag = "${var.network}-loadbalancer-rpc"

  depends_on = [
    digitalocean_droplet.seed,
    digitalocean_droplet.sentry,
    digitalocean_volume.seed_volumes,
    digitalocean_volume.sentry_volumes,
    digitalocean_volume_attachment.seed,
    digitalocean_volume_attachment.sentry,
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer - Rest
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_loadbalancer" "rest_lb" {
  name     = "${var.network}-rest-lb"
  region   = var.do_region
  vpc_uuid = digitalocean_vpc.cheqd_network.id

  algorithm = var.do_rest_lb_algorithm
  size      = var.do_rest_lb_size

  dynamic "forwarding_rule" {
    for_each = var.do_rest_lb_config

    content {
      entry_port      = forwarding_rule.value.entry_port
      entry_protocol  = forwarding_rule.value.entry_protocol
      target_port     = forwarding_rule.value.target_port
      target_protocol = forwarding_rule.value.target_protocol

      certificate_name = parseint(forwarding_rule.value.entry_port, 10) == 443 ? data.digitalocean_certificate.cheqd.name : null
    }
  }

  sticky_sessions {
    type = "none"
  }

  redirect_http_to_https = true

  healthcheck {
    protocol = var.do_rest_health_check_protocol
    port     = var.do_rest_health_check_port
    path     = "/cosmos/base/tendermint/v1beta1/syncing"
  }

  droplet_tag = "${var.network}-loadbalancer-rest"

  depends_on = [
    digitalocean_droplet.seed,
    digitalocean_droplet.sentry,
    digitalocean_volume.seed_volumes,
    digitalocean_volume.sentry_volumes,
    digitalocean_volume_attachment.seed,
    digitalocean_volume_attachment.sentry,
  ]
}
