resource "digitalocean_droplet" "seed" {
  #checkov:skip=CKV_DIO_2:We do not need to pass SSH keys here, it's managed via Ansible

  for_each = var.seed_droplet_config

  graceful_shutdown = true
  ipv6              = true
  size              = each.value.size
  image             = var.do_image_name
  region            = each.value.region
  vpc_uuid          = digitalocean_vpc.cheqd_network.id
  name              = "${var.network}-${each.key}"
  monitoring        = lookup(each.value, "monitoring", true)
  droplet_agent     = lookup(each.value, "enable_droplet_agent", true)
  backups           = lookup(each.value, "enable_backups", true)
  user_data         = templatefile("./templates/seed_user_data.tpl", var.seed_user_data)
  tags              = concat(var.default_tags, ["${var.network}-seed"])
}

resource "digitalocean_volume" "seed_volumes" {
  for_each = var.seed_droplet_config

  region                  = each.value.region
  size                    = each.value.volume_size
  name                    = "${each.key}-chain-data"
  initial_filesystem_type = lookup(each.value, "fs_type", "xfs")
  description             = "Volume used for storing the chain data for ${each.key} droplet"
  tags                    = concat(var.default_tags, ["${var.network}-seed"])
}

resource "digitalocean_volume_attachment" "seed" {
  for_each = var.seed_droplet_config

  droplet_id = digitalocean_droplet.seed[each.key].id
  volume_id  = digitalocean_volume.seed_volumes[each.key].id
}

resource "digitalocean_droplet" "sentry" {
  #checkov:skip=CKV_DIO_2:We do not need to pass SSH keys here, it's managed via Ansible

  for_each = var.sentry_droplet_config

  graceful_shutdown = true
  ipv6              = true
  size              = each.value.size
  image             = var.do_image_name
  region            = each.value.region
  vpc_uuid          = digitalocean_vpc.cheqd_network.id
  name              = "${var.network}-${each.key}"
  monitoring        = lookup(each.value, "monitoring", true)
  backups           = lookup(each.value, "enable_backups", true)
  droplet_agent     = lookup(each.value, "enable_droplet_agent", true)
  user_data         = templatefile("./templates/sentry_user_data.tpl", var.sentry_user_data)
  tags              = concat(var.default_tags, ["${var.network}-sentry"])
}

resource "digitalocean_volume" "sentry_volumes" {
  for_each = var.sentry_droplet_config

  region                  = each.value.region
  size                    = each.value.volume_size
  name                    = "${each.key}-chain-data"
  initial_filesystem_type = lookup(each.value, "fs_type", "xfs")
  description             = "Volume used for storing the chain data for ${each.key} droplet"
  tags                    = concat(var.default_tags, ["${var.network}-sentry"])
}

resource "digitalocean_volume_attachment" "sentry" {
  for_each = var.sentry_droplet_config

  droplet_id = digitalocean_droplet.sentry[each.key].id
  volume_id  = digitalocean_volume.sentry_volumes[each.key].id
}

resource "digitalocean_droplet" "validator" {
  #checkov:skip=CKV_DIO_2:We do not need to pass SSH keys here, it's managed via Ansible

  for_each = var.validator_droplet_config

  graceful_shutdown = true
  ipv6              = true
  size              = each.value.size
  image             = var.do_image_name
  region            = each.value.region
  vpc_uuid          = digitalocean_vpc.cheqd_network.id
  name              = "${var.network}-${each.key}"
  monitoring        = lookup(each.value, "monitoring", true)
  droplet_agent     = lookup(each.value, "enable_droplet_agent", true)
  backups           = lookup(each.value, "enable_backups", true)
  user_data         = templatefile("./templates/validator_user_data.tpl", var.validator_user_data)
  tags              = concat(var.default_tags, ["${var.network}-validator"])
}

resource "digitalocean_volume" "validator_volumes" {
  for_each = var.validator_droplet_config

  region                  = each.value.region
  size                    = each.value.volume_size
  name                    = "${each.key}-chain-data"
  initial_filesystem_type = lookup(each.value, "fs_type", "xfs")
  description             = "Volume used for storing the chain data for ${each.key} droplet"
  tags                    = concat(var.default_tags, ["${var.network}-validator"])
}

resource "digitalocean_volume_attachment" "validator" {
  for_each = var.validator_droplet_config

  droplet_id = digitalocean_droplet.validator[each.key].id
  volume_id  = digitalocean_volume.validator_volumes[each.key].id
}
