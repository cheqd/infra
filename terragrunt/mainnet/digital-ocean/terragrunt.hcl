# ----------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------
# This is a Digital Ocean specific configuration that provisions components for a desired network (e.g. testnet).
# Terraform code used by the Terragrunt configuration described here is located at the following path:
# github.com/cheqd/cheqd-infra/terraform/digital-ocean/

# ---------------------------------------------------------------------------------------------------------------------
# Use the open-sourced cheqd Terraform code located in the cheqd-infra repository.
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  source = "git::https://github.com/cheqd/cheqd-infra.git//terraform/digital-ocean?ref=${include.root.inputs.tag}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Include configurations that are common   across multiple environments.
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
#dependencies {
#}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this configuration.
# ---------------------------------------------------------------------------------------------------------------------
# Inputs which will be fed to the Terraform configuration selected above
inputs = {
  # Digital Ocean authorisation token. Passed as an environment variable.
  do_token = get_env("DO_TOKEN")
  # Digital Ocean default tags which will be applied to resources which accept them.
  default_tags = ["Terraform", "Mainnet"]

  # Digital Ocean Region in which the resources will be provisioned.
  do_region = "ams3"
  # Digital Ocean Network/VPC network range in which the resources will be created.
  # Note: Digital Ocean considers internal traffic to be secure, and does not allow restricting it.
  do_network_ip_range = "10.100.0.0/16"

  # Droplet configuration for SEED nodes.
  seed_droplet_config = {
    "seed1-ap" = local.node_droplet_config
  }
  # Firewall configuration for SEED nodes.
  seed_firewall = {
    inbound = merge(
      local.firewall_inbound_p2p,
      local.firewall_inbound_tendermint_internal,
      local.firewall_inbound_rest_internal,
      local.firewall_inbound_ssh,
    )
    outbound = local.firewall_node_outbound
  }

  # Droplet configuration for SENTRY nodes.
  sentry_droplet_config = {
    "sentry1-ap" = local.node_droplet_config
  }
  # Firewall configuration for SENTRY nodes.
  sentry_firewall = {
    inbound = merge(
      local.firewall_inbound_p2p,
      local.firewall_inbound_tendermint_internal,
      local.firewall_inbound_rest_internal,
      local.firewall_inbound_ssh,
    )
    outbound = local.firewall_node_outbound
  }

  # Droplet configuration for VALIDATOR nodes.
  validator_droplet_config = {
    "validator1-ap" = local.node_droplet_config
  }
  # Firewall configuration for VALIDATOR nodes.
  validator_firewall = {
    inbound  = local.firewall_inbound_ssh
    outbound = local.firewall_node_outbound
  }

  # Load Balancer configuration.
  do_rpc_health_check_port     = 26657
  do_rpc_health_check_protocol = "http"
  do_rpc_lb_config = {

    https_to_tendermint = {
      entry_port      = 443
      entry_protocol  = "https"
      target_port     = 26657
      target_protocol = "http"

      health_check_port     = 26657
      health_check_protocol = "http"
    }
  }

  do_rest_health_check_port     = 1317
  do_rest_health_check_protocol = "http"
  do_rest_lb_config = {

    http_to_p2p = {
      entry_port      = 443
      entry_protocol  = "https"
      target_port     = 1317
      target_protocol = "http"

      health_check_port     = 80
      health_check_protocol = "http"
    }
  }
}

locals {
  # DigitalOcean Droplet Configuration
  node_droplet_config = {
    region      = "ams3"
    size        = "s-4vcpu-8gb-intel"
    volume_size = 200
  }
  # DigitalOcean Load Balancer Firewall Rules
  ## Common Rules
  firewall_node_outbound = {
    "tcp-all" = {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = "0.0.0.0/0,::/0"
    }
    "udp-dns" = {
      protocol              = "udp"
      port_range            = "53"
      destination_addresses = "0.0.0.0/0,::/0"
    }
  }
  ### Common Rules - Seed and Sentry
 
  firewall_inbound_p2p = {
    "p2p_public" = {
      protocol         = "tcp"
      port_range       = "26656"
      source_addresses = "0.0.0.0/0,::/0"
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
  firewall_inbound_tendermint_internal = {
    "tendermint_internal" = {
      protocol         = "tcp"
      port_range       = "26657"
      source_addresses = "10.100.0.0/16" # VPC - var.do_network_ip_range from inputs
    }
  }
  firewall_inbound_rest_internal = {
    "rest_internal" = {
      protocol         = "tcp"
      port_range       = "1317"
      source_addresses = "10.100.0.0/16" # VPC - var.do_network_ip_range from inputs
    }
  }

  ### Custom Rules - Seed Node
  ### Custom Rules - Sentry Node
  ### Custom Rules - Validator Node
}
