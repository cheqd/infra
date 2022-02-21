terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.9.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email                = var.cf_email
  api_key              = var.cf_api_key
  api_user_service_key = var.api_user_service_key
}
