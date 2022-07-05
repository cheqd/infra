# ----------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------
# Top level Terragrunt configuration that is common for all child configurations. This configuration is merged into
# them, and applied to the bottom level configuration.

# ---------------------------------------------------------------------------------------------------------------------
# Use the open-sourced cheqd Terraform code located in the cheqd-infra repository.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Local variables for this configuration.
# ---------------------------------------------------------------------------------------------------------------------
# Environments or networks are determined by the value of the "network" variable present in the network.hcl file.
# Code written below allows us to feed that value into this configuration, which will later be merged by child modules.
locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("network.hcl"))
  network          = local.environment_vars.locals.network
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this configuration.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  tag     = "main"
  network = local.environment_vars.locals.network
}

# ---------------------------------------------------------------------------------------------------------------------
# Common Remote state for all configurations.
# ---------------------------------------------------------------------------------------------------------------------
# The Remote state uses a common Digital Ocean Spaces bucket. What differs between networks/environments is key for
# those buckets. Value of the key is determined by the network variable, taken from network/environment-specific
# network.hcl file.
remote_state {
  backend = "s3"
  config = {
    endpoint                    = "<s3-bucket-endpoint-here>"
    bucket                      = "<put-your-bucket-name-here>"
    region                      = "us-east-1"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_bucket_versioning      = true
    encrypt                     = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
