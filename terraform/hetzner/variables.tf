# ----------------------------------------------------------------------------------------------------------------------
# Authentication
# ----------------------------------------------------------------------------------------------------------------------
variable "hcloud_token" {
  description = "Authentication token for Hetzner."
  type        = string
  sensitive   = true
}

# ----------------------------------------------------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------------------------------------------------
variable "network" {
  description = "Hetzner VPC/Network name."
  type        = string
}

variable "hetzner_network_ip_range" {
  description = "Hezner VPC/Network IP range in CIDR notation."
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# Geolocation
# ----------------------------------------------------------------------------------------------------------------------
variable "hetzner_region" {
  description = "Hetzner dedicated region for resources to be provisioned in."
  type        = string
}

variable "hetzner_zone" {
  description = "Hetzner zone for network subnets. Can be one of 'eu-central' or 'us-east'."
  type        = string
  default     = "eu-central"
}

# ----------------------------------------------------------------------------------------------------------------------
# Seed node
# ----------------------------------------------------------------------------------------------------------------------
variable "seed_server_config" {
  description = "Custom configuration for seed servers."
  type        = map(map(string))
}

variable "seed_firewall" {
  description = "Firewall rules for seed servers."
  type        = map(map(map(string)))
  default = {
    inbound  = {}
    outbound = {}
  }
}

variable "seed_user_data" {
  description = "User data to be applied on server boot for seed servers."
  type        = map(string)
  default     = {}
}

# ----------------------------------------------------------------------------------------------------------------------
# Sentry node
# ----------------------------------------------------------------------------------------------------------------------
variable "sentry_server_config" {
  description = "Custom configuration for seed servers."
  type        = map(map(string))
}

variable "sentry_firewall" {
  description = "Firewall rules for sentry servers."
  type        = map(map(map(string)))
  default = {
    inbound  = {}
    outbound = {}
  }
}

variable "sentry_user_data" {
  description = "User data to be applied on server boot for sentry servers."
  type        = map(string)
  default     = {}
}

# ----------------------------------------------------------------------------------------------------------------------
# Validator node
# ----------------------------------------------------------------------------------------------------------------------
variable "validator_server_config" {
  description = "Custom configuration for validator servers."
  type        = map(map(string))
}

variable "validator_firewall" {
  description = "Firewall rules for validator servers."
  type        = map(map(map(string)))
  default = {
    inbound  = {}
    outbound = {}
  }
}

variable "validator_user_data" {
  description = "User data to be applied on server boot for validator servers."
  type        = map(string)
  default     = {}
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer
# ----------------------------------------------------------------------------------------------------------------------
variable "hetzner_lb_type" {
  description = "Type of the Hetzner's Load Balancer/"
  type        = string
  default     = "lb11"
}

# ----------------------------------------------------------------------------------------------------------------------
# Miscellaneous
# ----------------------------------------------------------------------------------------------------------------------
variable "hetzner_image_name" {
  description = "Desired OS to be installed on servers."
  type        = string
  default     = "ubuntu-20.04"
}
