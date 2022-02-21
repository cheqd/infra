resource "cloudflare_access_policy" "cheqd" {
  for_each = cloudflare_access_application.ssh

  application_id = each.value.id
  zone_id        = data.cloudflare_zone.cheqd.id
  name           = "Allow - SSH"
  precedence     = "1"
  decision       = "allow"

  include {
    login_method = [data.cloudflare_access_identity_provider.google.id]
  }

  require {
    device_posture = [cloudflare_device_posture_rule.default.id]
  }
}

data "cloudflare_access_identity_provider" "google" {
  name       = "Google Workspace"
  account_id = data.cloudflare_zone.cheqd.account_id
}

resource "cloudflare_access_group" "ssh_group" {
  zone_id = data.cloudflare_zone.cheqd.id
  name    = "${var.network} - SSH Group"

  include {
    geo = var.cf_access_ssh_locations
  }

  include {
    login_method = [data.cloudflare_access_identity_provider.google.id]
  }

  include {
    device_posture = [cloudflare_device_posture_rule.default.id]
  }

  require {
    gsuite {
      email                = var.cf_access_gsuite_emails
      identity_provider_id = data.cloudflare_access_identity_provider.google.id
    }
  }
}


resource "cloudflare_device_posture_rule" "default" {
  account_id  = data.cloudflare_zone.cheqd.account_id
  name        = "${var.network} - Default SSH Device Posture"
  type        = "serial_number"
  description = "Device posture rule for corporate devices"
  schedule    = "24h"

  match {
    platform = "linux"
  }

  match {
    platform = "mac"
  }

  match {
    platform = "windows"
  }

  ## Cloudflare Warp Should be installed and running
  input {
    path    = "/usr/local/bin/warp-cli"
    running = true
  }

  ## Macos Version - Min Big Sur Latest
  input {
    version  = "11.6.4"
    operator = ">="
  }

  ## Firewall Enabled
  input {
    enabled = true
  }

  ## Requite Encryption for All Disks on Host
  input {
    require_all = true
  }
}
