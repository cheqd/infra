terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.3.1"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

## All the configuration for vault provider goes via environment variables
provider "vault" {}
