# ----------------------------------------------------------------------------------------------------------------------
# Project
# ----------------------------------------------------------------------------------------------------------------------
resource "digitalocean_project" "cheqd" {
  name        = "cheqd - ${var.network}"
  description = "(Terraform) Project dedicated to testing Terragrunt configuration."
  purpose     = "Other"
  environment = "Development"

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
