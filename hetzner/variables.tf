variable "hcloud_token" {
  description = "Authentication token for Hetzner."
  type        = string
}

variable "network" {
  description = "Hetzner VPC/Network name."
  type        = string
}

variable "hetzner_region" {
  description = "Hetzner dedicated region for resources to be provisioned in."
  type        = string
}

variable "hetzner_zone" {
  description = "Hetzner zone for different subnets."
  type        = string
  default     = "eu-central"
}

variable "hetzner_network_ip_range" {
  description = "Hezner VPC/Network IP range CIDR block."
  type        = string
}

variable "hetzner_image_name" {
  description = "OS to be installed on servers."
  type        = string
  default     = "ubuntu-20-04-x64"
}

variable "seed_server_config" {
  description = "Custom configuration for seed servers."
  type        = map(map(string))
}

variable "seed_user_data" {
  description = "User data to be applied on server boot for seed servers."
  type        = map(string)
  default     = {}
}

variable "seed_firewall" {
  description = "Firewall rules for seed servers."
  type        = map(map(map(string)))
  default     = {
    inbound   = {}
    outbound  = {}
  }
}

variable "sentry_server_config" {
  description = "Custom configuration for seed servers."
  type        = map(map(string))
}

variable "sentry_user_data" {
  description = "User data to be applied on server boot for sentry servers."
  type        = map(string)
  default     = {}
}

variable "sentry_firewall" {
  description = "Firewall rules for sentry servers."
  type        = map(map(map(string)))
  default     = {
    inbound   = {}
    outbound  = {}
  }
}

variable "validator_server_config" {
  description = "Custom configuration for validator servers."
  type        = map(map(string))
}

variable "validator_user_data" {
  description = "User data to be applied on server boot for validator servers."
  type        = map(string)
  default     = {}
}

variable "validator_firewall" {
  description = "Firewall rules for validator servers."
  type        = map(map(map(string)))
  default     = {
    inbound   = {}
    outbound  = {}
  }
}

variable "hetzner_lb_type" {
  description = "Type of the Hetzner's Load Balancer/"
  type        = string
  default     = "lb11"
}

variable "rpc_certificate" {
  description = "Name of the certificate to be used by the rpc load balancer in corresponding Hetzner's project."
  type        = string
  default     = "rpc"
}

variable "api_certificate" {
  description = "Name of the certificate to be used by the api load balancer in corresponding Hetzner's project."
  type        = string
  default     = "api"
}
