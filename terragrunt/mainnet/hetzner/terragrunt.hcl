# ----------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------
# This is a Hetzner specific configuration that provisions components for a desired network (e.g. testnet).
# Terraform code used by the Terragrunt configuration described here is located at the following path:
# github.com/cheqd/cheqd-infra/terraform/hetzner/

# ---------------------------------------------------------------------------------------------------------------------
# Use the open-sourced cheqd Terraform code located in the cheqd-infra repository.
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  source = "git::https://github.com/cheqd/cheqd-infra.git//terraform/hetzner?ref=${include.root.inputs.tag}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Include configurations that are common across multiple environments.
# ---------------------------------------------------------------------------------------------------------------------
# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

# ---------------------------------------------------------------------------------------------------------------------
# Provide dependencies for the local Terragrunt configuration.
# ---------------------------------------------------------------------------------------------------------------------
# Dependencies selected here will determine the order in which resources for an environment/network will be created.
# Each dependency in the list below has to be created before the resources described here.
dependencies {
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this configuration.
# ---------------------------------------------------------------------------------------------------------------------
# Inputs which will be fed to the Terraform configuration selected above
inputs = {
  # Hetzner authorisation token. Passed as an environment variable.
  hcloud_token = get_env("HCLOUD_TOKEN")

  # Hetzner region where the resources will be provisioned.
  hetzner_region = "nbg1"
  # Hetzner zone. This is common access all the European regions (fsn1, nbg1, hel1). Used by Hetzner Network Subnets.
  hetzner_zone = "eu-central"
  # Hetzner Network/VPC IP range.
  hetzner_network_ip_range = "10.100.0.0/16"

  # Server configuration for SEED nodes.
  seed_server_config = {
    "seed1-eu" = local.node_server_config
  }
  # Firewall configuration for SEED nodes.
  seed_firewall = {
    inbound  = merge(local.firewall_inbound_p2p_public, local.firewall_inbound_tendermint_public, local.firewall_inbound_ssh)
    outbound = local.node_firewall_outbound
  }

  # Server configuration for SENTRY nodes.
  sentry_server_config = {
    "sentry1-eu" = local.node_server_config
  }
  # Firewall configuration for SENTRY nodes.
  sentry_firewall = {
    inbound  = merge(local.firewall_inbound_p2p_public, local.firewall_inbound_tendermint_public, local.firewall_inbound_ssh)
    outbound = local.node_firewall_outbound
  }

  # Server configuration for VALIDATOR nodes.
  validator_server_config = {
    "validator1-eu" = local.node_server_config
  }
  # Firewall configuration for VALIDATOR nodes.
  validator_firewall = {
    inbound  = local.firewall_inbound_ssh
    outbound = local.node_firewall_outbound
  }
}

locals {
  # Hetzner Server Configuration
  node_server_config = {
    region      = "nbg1"
    size        = "cpx31"
    volume_size = 200
    fs_type     = "xfs"
  }
  # DigitalOcean Load Balancer Firewall Rules
  ## Cloudflare IPs
  cloudflare_ip_v4 = join(",", [
    "173.245.48.0/20", "103.21.244.0/22", "103.22.200.0/22", "103.31.4.0/22", "141.101.64.0/18",
    "108.162.192.0/18", "190.93.240.0/20", "188.114.96.0/20", "197.234.240.0/22", "198.41.128.0/17",
    "162.158.0.0/15", "104.16.0.0/13", "104.24.0.0/14", "172.64.0.0/13", "131.0.72.0/22"
  ]) # Get from https://www.cloudflare.com/ips-v4
  cloudflare_ip_v6 = join(",", [
    "2400:cb00::/32", "2606:4700::/32", "2803:f800::/32", "2405:b500::/32", "2405:8100::/32",
    "2a06:98c0::/29", "2c0f:f248::/32"
  ]) # Get from https://www.cloudflare.com/ips-v6
  ## Common Rules
  node_firewall_inbound = {
    "cloudflare" = {
      protocol         = "tcp"
      port_range       = "26656"
      source_addresses = join(",", [local.cloudflare_ip_v4, local.cloudflare_ip_v6])
      description      = "Cloudflare"
    }
  }
  node_firewall_outbound = {
    "tcp-all" = {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = "0.0.0.0/0,::/0"
      description           = "Outbound - Allow All"
    }
    "udp-dns" = {
      protocol              = "udp"
      port_range            = "53"
      destination_addresses = "0.0.0.0/0,::/0"
      description           = "UDP DNS Port"
    }
  }
  ## Custom Rules
  firewall_inbound_ssh = {
    "ssh-all" = {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = "0.0.0.0/0,::/0"
      description      = "SSH Public Access"
    }
  }
  firewall_inbound_p2p_public = {
    "p2p_public" = {
      protocol         = "tcp"
      port_range       = 26656
      source_addresses = "0.0.0.0/0,::/0"
      description      = "P2P Public Access"
    }
  }
  firewall_inbound_tendermint_public = {
    "tendermint_public" = {
      protocol         = "tcp"
      port_range       = 26657
      source_addresses = "0.0.0.0/0,::/0"
      description      = "Tendermint Public Access"
    }
  }
  ### Custom Rules - Seed Node
  ### Custom Rules - Sentry Node
  ### Custom Rules - Validator Node
}
