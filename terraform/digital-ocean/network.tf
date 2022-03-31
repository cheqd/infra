# ----------------------------------------------------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_vpc" "cheqd_network" {
  name        = var.network
  region      = var.do_region
  ip_range    = var.do_network_ip_range
  description = "VPC for ${var.network}"
}

resource "digitalocean_firewall" "seed" {
  name  = "${var.network}-seed"
  count = (length(var.seed_firewall.inbound) > 0 || length(var.seed_firewall.outbound) > 0) ? 1 : 0

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

  tags = ["${var.network}-seed"]
}

resource "digitalocean_firewall" "sentry" {
  name  = "${var.network}-sentry"
  count = (length(var.sentry_firewall.inbound) > 0 || length(var.sentry_firewall.outbound) > 0) ? 1 : 0

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

  tags = ["${var.network}-sentry"]
}

resource "digitalocean_firewall" "validator" {
  name  = "${var.network}-validator"
  count = (length(var.validator_firewall.inbound) > 0 || length(var.validator_firewall.outbound) > 0) ? 1 : 0

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

  tags = ["${var.network}-validator"]
}
