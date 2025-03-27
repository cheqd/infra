# ----------------------------------------------------------------------------------------------------------------------
# Authentication
# ----------------------------------------------------------------------------------------------------------------------
variable "do_token" {
  description = "Authentication token for DigitalOcean"
  type        = string
  sensitive   = true
}

# ----------------------------------------------------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------------------------------------------------
variable "network" {
  description = "DigitalOcean VPC/Network name"
  type        = string
}

variable "do_network_ip_range" {
  description = "DigitalOcean VPC/Network IP range in CIDR notation"
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# Geolocation
# ----------------------------------------------------------------------------------------------------------------------
variable "do_region" {
  description = "DigitalOcean Region"
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# Node Firewall
# ----------------------------------------------------------------------------------------------------------------------
variable "node_firewall_public" {
  description = "Common firewall rules for public traffic"
  type        = map(map(map(string)))
  default = {
    inbound  = {}
    outbound = {}
  }
}

variable "node_firewall_restricted" {
  description = "Common firewall rules for restricted traffic"
  type        = map(map(map(string)))
  default = {
    inbound  = {}
    outbound = {}
  }
}

variable "node_firewall_developer" {
  description = "Developer firewall rules for debugging purposes"
  type        = map(map(map(string)))
  default = {
    inbound  = {}
    outbound = {}
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Seed node
# ----------------------------------------------------------------------------------------------------------------------
variable "seed_droplet_config" {
  description = "Custom configuration for seed servers"
  type        = map(any)
}

variable "seed_user_data" {
  description = "User data to be applied on server boot for seed servers"
  type        = map(string)
  default     = {}
}

# ----------------------------------------------------------------------------------------------------------------------
# Sentry node
# ----------------------------------------------------------------------------------------------------------------------
variable "sentry_droplet_config" {
  description = "Custom configuration for sentry servers"
  type        = map(any)
}

variable "sentry_user_data" {
  description = "User data to be applied on server boot for sentry servers"
  type        = map(string)
  default     = {}
}

# ----------------------------------------------------------------------------------------------------------------------
# Archive node
# ----------------------------------------------------------------------------------------------------------------------
variable "archive_droplet_config" {
  description = "Custom configuration for archive servers"
  type        = map(any)
}

variable "archive_user_data" {
  description = "User data to be applied on server boot for archive servers"
  type        = map(string)
  default     = {}
}

variable "archive_region" {
  description = "DO Region for archive node resources"
  type        = string
  default     = "sgp1"
}

# ----------------------------------------------------------------------------------------------------------------------
# Validator nodeUser data to be applied on server boot for archive servers
# ----------------------------------------------------------------------------------------------------------------------
variable "validator_droplet_config" {
  description = "Custom configuration for validator servers"
  type        = map(any)
}

variable "validator_user_data" {
  description = "User data to be applied on server boot for validator servers"
  type        = map(string)
  default     = {}
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer - RPC
# ----------------------------------------------------------------------------------------------------------------------
variable "do_rpc_lb_config" {
  description = "RPC Load Balancer configuration"
  type        = map(map(string))
}

variable "do_rpc_lb_algorithm" {
  description = "RPC Load Balancer algorithm to be used"
  type        = string
  default     = "least_connections"
}

variable "do_rpc_lb_size" {
  description = "RPC Load Balancer type/size"
  type        = string
  default     = "lb-small"
}

variable "do_rpc_health_check_port" {
  description = "Target port that the RPC Load Balancer will perform health checks"
  type        = number
}

variable "do_rpc_health_check_protocol" {
  description = "Protocol that the RPC Load Balancer will use for health checks"
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer - Rest
# ----------------------------------------------------------------------------------------------------------------------
variable "do_rest_lb_config" {
  description = "Rest Load Balancer configuration"
  type        = map(map(string))
}

variable "do_rest_lb_algorithm" {
  description = "Rest Load Balancer algorithm to be used"
  type        = string
  default     = "least_connections"
}

variable "do_rest_lb_size" {
  description = "Rest Load Balancer type/size"
  type        = string
  default     = "lb-small"
}

variable "do_rest_health_check_port" {
  description = "Target port that the Rest Load Balancer will perform health checks"
  type        = number
  default     = 80
}

variable "do_rest_health_check_protocol" {
  description = "Protocol that the Rest Load Balancer will use for health checks"
  type        = string
  default     = "http"
}

# ----------------------------------------------------------------------------------------------------------------------
# Miscellaneous
# ----------------------------------------------------------------------------------------------------------------------
variable "do_image_name" {
  description = "Desired OS to be installed on servers"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "default_tags" {
  description = "Tags to be applied to all available resources"
  type        = list(string)
}

variable "archive_lb" {
  description = "Whether to create an archive load balancer"
  type        = bool
  default     = false
}

variable "do_archive_lb_certificate_name" {
  description = "Name of the archive load balancer certificate"
  type        = string
}
