resource "hcloud_server" "seed" {
  depends_on = [hcloud_network_subnet.seed, hcloud_network_subnet.rest_lb, hcloud_network_subnet.rpc_lb]
  for_each   = var.seed_server_config

  name        = "${var.network}-${each.key}"
  location    = each.value.region
  image       = var.hetzner_image_name
  server_type = each.value.size
  network {
    network_id = hcloud_network.cheqd_network.id
    ip         = trimsuffix(cidrsubnet(hcloud_network_subnet.seed.ip_range, 8, 100 + index(keys(var.seed_server_config), each.key)), "/32")
    alias_ips = [
      trimsuffix(cidrsubnet(hcloud_network_subnet.rest_lb.ip_range, 8, 100 + index(keys(var.seed_server_config), each.key)), "/32"),
      trimsuffix(cidrsubnet(hcloud_network_subnet.rpc_lb.ip_range, 8, 100 + index(keys(var.seed_server_config), each.key)), "/32")
    ]
  }
  placement_group_id = hcloud_placement_group.seed.id
  user_data          = templatefile("./templates/seed_user_data.tpl", var.seed_user_data)
  backups            = var.network == "testnet" || var.network == "mainnet" ? true : false

  labels = {
    "ServerType" = "Node"
    "NodeType"   = "seed"
    "Terraform"  = "True"
  }
}

resource "hcloud_volume" "seed" {
  for_each = var.seed_server_config

  name     = "${each.key}-chain-data"
  location = each.value.region
  size     = each.value.volume_size
  format   = lookup(each.value, "fs_type", "xfs")
}

resource "hcloud_volume_attachment" "seed" {
  for_each = var.seed_server_config

  volume_id = hcloud_volume.seed[each.key].id
  server_id = hcloud_server.seed[each.key].id
  automount = true
}

resource "hcloud_server" "sentry" {
  depends_on = [hcloud_network_subnet.sentry, hcloud_network_subnet.rest_lb, hcloud_network_subnet.rpc_lb]
  for_each   = var.sentry_server_config

  name        = "${var.network}-${each.key}"
  location    = each.value.region
  image       = var.hetzner_image_name
  server_type = each.value.size
  network {
    network_id = hcloud_network.cheqd_network.id
    ip         = trimsuffix(cidrsubnet(hcloud_network_subnet.sentry.ip_range, 8, 150 + index(keys(var.sentry_server_config), each.key)), "/32")
    alias_ips = [
      trimsuffix(cidrsubnet(hcloud_network_subnet.rest_lb.ip_range, 8, 150 + index(keys(var.sentry_server_config), each.key)), "/32"),
      trimsuffix(cidrsubnet(hcloud_network_subnet.rpc_lb.ip_range, 8, 150 + index(keys(var.sentry_server_config), each.key)), "/32")
    ]
  }
  placement_group_id = hcloud_placement_group.sentry.id
  user_data          = templatefile("./templates/sentry_user_data.tpl", var.sentry_user_data)
  backups            = var.network == "testnet" || var.network == "mainnet" ? true : false

  labels = {
    "ServerType" = "Node"
    "NodeType"   = "sentry"
    "Terraform"  = "True"
  }
}

resource "hcloud_volume" "sentry" {
  for_each = var.sentry_server_config

  name     = "${each.key}-chain-data"
  location = each.value.region
  size     = each.value.volume_size
  format   = lookup(each.value, "fs_type", "xfs")
}

resource "hcloud_volume_attachment" "sentry" {
  for_each = var.sentry_server_config

  volume_id = hcloud_volume.sentry[each.key].id
  server_id = hcloud_server.sentry[each.key].id
  automount = true
}

resource "hcloud_server" "validator" {
  depends_on = [hcloud_network_subnet.validator]
  for_each   = var.validator_server_config

  name        = "${var.network}-${each.key}"
  location    = each.value.region
  image       = var.hetzner_image_name
  server_type = each.value.size
  network {
    network_id = hcloud_network.cheqd_network.id
    ip         = trimsuffix(cidrsubnet(hcloud_network_subnet.validator.ip_range, 8, 200 + index(keys(var.validator_server_config), each.key)), "/32")
    alias_ips = [
      trimsuffix(cidrsubnet(hcloud_network_subnet.sentry.ip_range, 8, 200 + index(keys(var.validator_server_config), each.key)), "/32")
    ]
  }
  placement_group_id = hcloud_placement_group.validator.id
  user_data          = templatefile("./templates/validator_user_data.tpl", var.validator_user_data)
  backups            = var.network == "testnet" || var.network == "mainnet" ? true : false

  labels = {
    "ServerType" = "Node"
    "NodeType"   = "validator"
    "Terraform"  = "True"
  }
}

resource "hcloud_volume" "validator" {
  for_each = var.validator_server_config

  name     = "${each.key}-chain-data"
  location = each.value.region
  size     = each.value.volume_size
  format   = lookup(each.value, "fs_type", "xfs")
}

resource "hcloud_volume_attachment" "validator" {
  for_each = var.validator_server_config

  volume_id = hcloud_volume.validator[each.key].id
  server_id = hcloud_server.validator[each.key].id
  automount = true
}

resource "hcloud_placement_group" "seed" {
  name = "${var.network}-seed"
  type = "spread"
  labels = {
    "Network"   = var.network
    "NodeType"  = "seed"
    "Terraform" = "True"
  }
}

resource "hcloud_placement_group" "sentry" {
  name = "${var.network}-sentry"
  type = "spread"
  labels = {
    "Network"   = var.network
    "NodeType"  = "sentry"
    "Terraform" = "True"
  }
}

resource "hcloud_placement_group" "validator" {
  name = "${var.network}-validator"
  type = "spread"
  labels = {
    "Network"   = var.network
    "NodeType"  = "validator"
    "Terraform" = "True"
  }
}
