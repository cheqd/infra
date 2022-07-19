terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.34.3"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
