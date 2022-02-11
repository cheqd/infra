resource "digitalocean_vpc" "cheqd_network" {
  name     = var.network
  region   = var.do_region
  ip_range = var.do_network_ip_range
}

resource "digitalocean_firewall" "seeds" {
  name        = "${var.network}-seeds"
  droplet_ids = [for droplet in digitalocean_droplet.seeds : droplet.id]

  dynamic "inbound_rule" {
    for_each = var.seeds_firewall.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = split(",", inbound_rule.value.source_addresses)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.seeds_firewall.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }
}

resource "digitalocean_firewall" "sentries" {
  name        = "${var.network}-sentries"
  droplet_ids = [for droplet in digitalocean_droplet.sentries : droplet.id]

  dynamic "inbound_rule" {
    for_each = var.sentries_firewall.inbound

    content {
      port_range       = inbound_rule.value["port_range"]
      protocol         = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses = split(",", inbound_rule.value.source_addresses)
    }
  }

  dynamic "outbound_rule" {
    for_each = var.sentries_firewall.outbound

    content {
      port_range            = outbound_rule.value["port_range"]
      protocol              = lookup(outbound_rule.value, "protocol", "tcp")
      destination_addresses = split(",", outbound_rule.value.destination_addresses)
    }
  }
}
