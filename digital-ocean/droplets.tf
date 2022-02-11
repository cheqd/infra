resource "digitalocean_droplet" "seeds" {
  for_each = var.seeds_droplet_config

  graceful_shutdown = true
  ipv6              = true
  size              = each.value.size
  image             = var.do_image_name
  region            = each.value.region
  vpc_uuid          = digitalocean_vpc.cheqd_network.id
  name              = "${var.network}-${each.value.name}"
  monitoring        = lookup(each.value, "monitoring", true)
  droplet_agent     = lookup(each.value, "enable_droplet_agent", false)
  user_data         = templatefile("./templates/seed_user_data.tpl", var.seeds_user_data)
}

resource "digitalocean_volume" "seed_volumes" {
  for_each = var.seeds_droplet_config

  region                  = each.value.region
  size                    = each.value.volume_size
  name                    = "${each.value.name}-chain-data"
  initial_filesystem_type = lookup(each.value, "fs_type", "ext4")
  description             = "Volume used for storing the chain data for ${each.value["name"]} droplet"
}

resource "digitalocean_volume_attachment" "seeds" {
  for_each = var.seeds_droplet_config

  droplet_id = digitalocean_droplet.seeds[each.key].id
  volume_id  = digitalocean_volume.seed_volumes[each.key].id
}

resource "digitalocean_droplet" "sentries" {
  for_each = var.sentries_droplet_config

  graceful_shutdown = true
  ipv6              = true
  size              = each.value.size
  image             = var.do_image_name
  region            = each.value.region
  vpc_uuid          = digitalocean_vpc.cheqd_network.id
  name              = "${var.network}-${each.value.name}"
  monitoring        = lookup(each.value, "monitoring", true)
  droplet_agent     = lookup(each.value, "enable_droplet_agent", false)
  user_data         = templatefile("./templates/sentry_user_data.tpl", var.sentry_user_data)
}

resource "digitalocean_volume" "sentry_volumes" {
  for_each = var.sentries_droplet_config

  region                  = each.value.region
  size                    = each.value.volume_size
  name                    = "${each.value.name}-chain-data"
  initial_filesystem_type = lookup(each.value, "fs_type", "ext4")
  description             = "Volume used for storing the chain data for ${each.value["name"]} droplet"
}

resource "digitalocean_volume_attachment" "sentries" {
  for_each = var.sentries_droplet_config

  droplet_id = digitalocean_droplet.sentries[each.key].id
  volume_id  = digitalocean_volume.sentry_volumes[each.key].id
}
