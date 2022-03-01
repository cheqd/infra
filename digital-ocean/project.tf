data "digitalocean_project" "cheqd" {
  name = var.do_project_name
}

resource "digitalocean_project_resources" "cheqd" {
  project = data.digitalocean_project.cheqd.id
  resources = concat(
    local.resources,
    [digitalocean_loadbalancer.cheqd.urn]
  )
}

locals {
  resources = [for resource in merge(
    digitalocean_droplet.seed,
    digitalocean_droplet.sentry,
    digitalocean_droplet.validator,
    digitalocean_volume.sentry_volumes,
    digitalocean_volume.seed_volumes,
    digitalocean_volume.validator_volumes,
    ) : resource.urn
  ]
}
