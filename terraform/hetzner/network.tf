# ----------------------------------------------------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------------------------------------------------
resource "hcloud_network" "cheqd_network" {
  name              = var.network
  ip_range          = var.hetzner_network_ip_range
  delete_protection = var.network == "testnet" || var.network == "mainnet" ? true : false

  labels = {
    "Network"   = var.network
    "Terraform" = "true"
  }
}

resource "hcloud_network_subnet" "rest_lb" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 100)
}

resource "hcloud_network_subnet" "rpc_lb" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 101)
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

resource "hcloud_network_subnet" "standalone_servers" {
  network_id   = hcloud_network.cheqd_network.id
  type         = "cloud"
  network_zone = var.hetzner_zone
  ip_range     = cidrsubnet(var.hetzner_network_ip_range, 8, 200)
}

resource "hcloud_firewall" "node_public" {
  count = (length(var.node_firewall_public.inbound) > 0 || length(var.node_firewall_public.outbound) > 0) ? 1 : 0
  name  = "${var.network}-node-public"

  labels = {
    "Terraform" = "True"
  }
  apply_to {
    label_selector = "NodeType=seed"
  }
  apply_to {
    label_selector = "NodeType=sentry"
  }

  dynamic "rule" {
    for_each = var.node_firewall_public.inbound

    content {
      direction   = "in"
      protocol    = lookup(rule.value, "protocol", "tcp")
      source_ips  = split(",", rule.value.source_addresses)
      port        = rule.value["port_range"]
      description = lookup(rule.value, "description", "Inbound rules created by Terraform.")
    }
  }

  dynamic "rule" {
    for_each = var.node_firewall_public.outbound

    content {
      direction       = "out"
      protocol        = lookup(rule.value, "protocol", "tcp")
      destination_ips = split(",", rule.value.destination_addresses)
      port            = rule.value["port_range"]
      description     = lookup(rule.value, "description", "Outbound rules created by Terraform.")
    }

  }
}

resource "hcloud_firewall" "node_restricted" {
  count = (length(var.node_firewall_restricted.inbound) > 0 || length(var.node_firewall_restricted.outbound) > 0) ? 1 : 0
  name  = "${var.network}-node-restricted"

  labels = {
    "Terraform" = "True"
  }
  apply_to {
    label_selector = "NodeType=sentry"
  }
  apply_to {
    label_selector = "NodeType=seed"
  }
  apply_to {
    label_selector = "NodeType=validator"
  }

  dynamic "rule" {
    for_each = var.node_firewall_restricted.inbound

    content {
      direction   = "in"
      protocol    = lookup(rule.value, "protocol", "tcp")
      source_ips  = split(",", rule.value.source_addresses)
      port        = rule.value["port_range"]
      description = lookup(rule.value, "description", "Inbound rules created by Terraform.")
    }
  }

  dynamic "rule" {
    for_each = var.node_firewall_restricted.outbound

    content {
      direction       = "out"
      protocol        = lookup(rule.value, "protocol", "tcp")
      destination_ips = split(",", rule.value.destination_addresses)
      port            = rule.value["port_range"]
      description     = lookup(rule.value, "description", "Outbound rules created by Terraform.")
    }

  }
}

resource "hcloud_firewall" "node_developer" {
  count = (length(var.node_firewall_developer.inbound) > 0 || length(var.node_firewall_developer.outbound) > 0) ? 1 : 0
  name  = "${var.network}-developer"

  labels = {
    "Terraform" = "True"
  }
  apply_to {
    label_selector = "NodeType=sentry"
  }
  apply_to {
    label_selector = "NodeType=seed"
  }
  apply_to {
    label_selector = "NodeType=validator"
  }

  dynamic "rule" {
    for_each = var.node_firewall_developer.inbound

    content {
      direction   = "in"
      protocol    = lookup(rule.value, "protocol", "tcp")
      source_ips  = split(",", rule.value.source_addresses)
      port        = rule.value["port_range"]
      description = lookup(rule.value, "description", "Inbound rules created by Terraform.")
    }
  }

  dynamic "rule" {
    for_each = var.node_firewall_developer.outbound

    content {
      direction       = "out"
      protocol        = lookup(rule.value, "protocol", "tcp")
      destination_ips = split(",", rule.value.destination_addresses)
      port            = rule.value["port_range"]
      description     = lookup(rule.value, "description", "Outbound rules created by Terraform.")
    }
  }
}
