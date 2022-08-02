# ----------------------------------------------------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_vpc" "cheqd_network" {
  name        = var.network
  region      = var.do_region
  ip_range    = var.do_network_ip_range
  description = "VPC for ${var.network}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Common Node Firewall
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_firewall" "node-public" {
  name  = "${var.network}-node-public"
  count = (length(var.node_firewall_public.inbound) > 0 || length(var.node_firewall_public.outbound) > 0) ? 1 : 0

  dynamic "inbound_rule" {
    for_each = var.node_firewall_public.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = lookup(inbound_rule.value, "source_addresses", "undefined") != "undefined" ? split(",", inbound_rule.value.source_addresses) : null
      source_tags      = lookup(inbound_rule.value, "source_tags", "undefined") != "undefined" ? split(",", inbound_rule.value.source_tags) : null
    }
  }

  dynamic "outbound_rule" {
    for_each = var.node_firewall_public.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }

  tags = ["${var.network}-seed", "${var.network}-sentry"]
}

resource "digitalocean_firewall" "node-restricted" {
  name  = "${var.network}-node-restricted"
  count = (length(var.node_firewall_restricted.inbound) > 0 || length(var.node_firewall_restricted.outbound) > 0) ? 1 : 0

  dynamic "inbound_rule" {
    for_each = var.node_firewall_restricted.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = lookup(inbound_rule.value, "source_addresses", "undefined") != "undefined" ? split(",", inbound_rule.value.source_addresses) : null
      source_tags      = lookup(inbound_rule.value, "source_tags", "undefined") != "undefined" ? split(",", inbound_rule.value.source_tags) : null
    }
  }

  dynamic "outbound_rule" {
    for_each = var.node_firewall_restricted.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }

  tags = ["${var.network}-seed", "${var.network}-sentry"]
}

# ----------------------------------------------------------------------------------------------------------------------
# Developer node Firewall
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_firewall" "node-developer" {
  name  = "${var.network}-node-developer"
  count = (length(var.node_firewall_developer.inbound) > 0 || length(var.node_firewall_developer.outbound) > 0) ? 1 : 0

  dynamic "inbound_rule" {
    for_each = var.node_firewall_developer.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = lookup(inbound_rule.value, "source_addresses", "undefined") != "undefined" ? split(",", inbound_rule.value.source_addresses) : null
      source_tags      = lookup(inbound_rule.value, "source_tags", "undefined") != "undefined" ? split(",", inbound_rule.value.source_tags) : null
    }
  }

  dynamic "outbound_rule" {
    for_each = var.node_firewall_developer.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }

  tags = ["${var.network}-seed", "${var.network}-sentry", "${var.network}-validator"]
}
