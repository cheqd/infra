resource "digitalocean_vpc" "cheqd_network" {
  name        = var.network
  region      = var.do_region
  ip_range    = var.do_network_ip_range
  description = "VPC for ${var.network}"
}

resource "digitalocean_firewall" "seed" {
  name        = "${var.network}-seed"
  droplet_ids = [for droplet in digitalocean_droplet.seed : droplet.id]

  dynamic "inbound_rule" {
    for_each = var.seed_firewall.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = split(",", inbound_rule.value.source_addresses)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.seed_firewall.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }

  tags = concat(var.default_tags, ["${var.network}-seed"])
}

resource "digitalocean_firewall" "sentry" {
  name        = "${var.network}-sentry"
  droplet_ids = [for droplet in digitalocean_droplet.sentry : droplet.id]

  dynamic "inbound_rule" {
    for_each = var.sentry_firewall.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = split(",", inbound_rule.value.source_addresses)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.sentry_firewall.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }

  tags = concat(var.default_tags, ["${var.network}-sentry"])
}

resource "digitalocean_firewall" "validator" {
  name        = "${var.network}-validator"
  droplet_ids = [for droplet in digitalocean_droplet.validator : droplet.id]

  dynamic "inbound_rule" {
    for_each = var.validator_firewall.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = split(",", inbound_rule.value.source_addresses)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.validator_firewall.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }

  tags = concat(var.default_tags, ["${var.network}-validator"])
}
