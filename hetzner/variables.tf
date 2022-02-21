variable "hcloud_token" {
  description = "Authentication token for Hetzner."
  type        = string
}

variable "environment" {
  description = "The environment where the infrastructure will be provisioned."
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
}

variable "seed_firewall" {
  description = "Firewall rules for seed servers."
  type        = map(map(map(string)))
}

variable "sentry_server_config" {
  description = "Custom configuration for seed servers."
  type        = map(map(string))
}

variable "sentry_user_data" {
  description = "User data to be applied on server boot for sentry servers."
  type        = map(string)
}

variable "sentry_firewall" {
  description = "Firewall rules for sentry servers."
  type        = map(map(map(string)))
}

variable "validator_server_config" {
  description = "Custom configuration for validator servers."
  type        = map(map(string))
}

variable "validator_user_data" {
  description = "User data to be applied on server boot for validator servers."
  type        = map(string)
}

variable "validator_firewall" {
  description = "Firewall rules for validator servers."
  type        = map(map(map(string)))
}
