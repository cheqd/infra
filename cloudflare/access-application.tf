resource "cloudflare_access_application" "ssh" {
  for_each = local.seeds_and_sentries

  zone_id          = data.cloudflare_zone.cheqd.id
  name             = "${var.network}-${each.key}-ssh"
  domain           = "${each.key}-${var.network}.${var.cf_domain}"
  type             = lookup(each.value, "cf_app_type", "self_hosted")
  session_duration = lookup(each.value, "cf_app_session_duration", "24h")
}

data "cloudflare_zone" "cheqd" {
  name = var.cf_domain
}

locals {
  seeds_and_sentries = merge(
    data.terraform_remote_state.do_output.outputs.seed_droplets,
    data.terraform_remote_state.do_output.outputs.sentry_droplets
  )
}
