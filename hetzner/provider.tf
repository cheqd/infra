terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.32.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.3.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

## All the configuration for vault provider goes via environment variables
provider "vault" {}
