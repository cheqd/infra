terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.32.2"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
