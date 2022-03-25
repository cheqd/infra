resource "digitalocean_project" "cheqd" {
  name        = "cheqd - ${var.network}"
  description = "Project dedicated to testing Terragrunt configuration."
  purpose     = "Other"
  environment = "Development"
}

resource "digitalocean_project_resources" "cheqd" {
  project = digitalocean_project.cheqd.id
  resources = concat(
    local.resources,
    [digitalocean_loadbalancer.rest_lb.urn, digitalocean_loadbalancer.rpc_lb.urn]
  )
}

locals {
  resources = [for resource in merge(
    digitalocean_droplet.seed,
    digitalocean_droplet.sentry,
    digitalocean_droplet.validator,
    ) : resource.urn
  ]
}
