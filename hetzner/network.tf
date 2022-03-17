resource "hcloud_network" "cheqd_network" {
  name     = var.network
  ip_range = var.hetzner_network_ip_range
  #  delete_protection =
  labels = {
    "Terraform"   = "true"
  }
}

resource "hcloud_network_subnet" "rest_lb" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 0)
}

resource "hcloud_network_subnet" "rpc_lb" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 1)
}

resource "hcloud_network_subnet" "seed" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 2)
}

resource "hcloud_network_subnet" "sentry" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 3)
}

resource "hcloud_network_subnet" "validator" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 4)
}

resource "hcloud_firewall" "seed" {
  name = "${var.network}-seed"

  labels = {
    "Terraform" = "True"
  }
  apply_to {
    label_selector = "NodeType=seed"
  }

  dynamic "rule" {
    for_each = var.seed_firewall.inbound

    content {
      direction  = "in"
      protocol   = lookup(rule.value, "protocol", "tcp")
      source_ips = split(",", rule.value.source_addresses)
      port       = rule.value["port_range"]
    }
  }

  dynamic "rule" {
    for_each = var.seed_firewall.outbound

    content {
      direction       = "out"
      protocol        = lookup(rule.value, "protocol", "tcp")
      destination_ips = split(",", rule.value.destination_addresses)
      port            = rule.value["port_range"]
    }

  }
}

resource "hcloud_firewall" "sentry" {
  name = "${var.network}-sentry"

  labels = {
    "Terraform" = "True"
  }
  apply_to {
    label_selector = "NodeType=sentry"
  }

  dynamic "rule" {
    for_each = var.sentry_firewall.inbound

    content {
      direction  = "in"
      protocol   = lookup(rule.value, "protocol", "tcp")
      source_ips = split(",", rule.value.source_addresses)
      port       = rule.value["port_range"]
    }
  }

  dynamic "rule" {
    for_each = var.sentry_firewall.outbound

    content {
      direction       = "out"
      protocol        = lookup(rule.value, "protocol", "tcp")
      destination_ips = split(",", rule.value.destination_addresses)
      port            = rule.value["port_range"]
    }

  }
}

resource "hcloud_firewall" "validator" {
  name = "${var.network}-validator"

  labels = {
    "Terraform" = "True"
  }
  apply_to {
    label_selector = "NodeType=validator"
  }

  dynamic "rule" {
    for_each = var.validator_firewall.inbound

    content {
      direction  = "in"
      protocol   = lookup(rule.value, "protocol", "tcp")
      source_ips = split(",", rule.value.source_addresses)
      port       = rule.value["port_range"]
    }
  }

  dynamic "rule" {
    for_each = var.validator_firewall.outbound

    content {
      direction       = "out"
      protocol        = lookup(rule.value, "protocol", "tcp")
      destination_ips = split(",", rule.value.destination_addresses)
      port            = rule.value["port_range"]
    }

  }
}