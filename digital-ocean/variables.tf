variable "do_token" {
  type = string
  description = "Authentication token for Digital Ocean."
}

variable "network" {
  type = string
}

variable "do_region" {
  type = string
}

variable "do_network_ip_range" {
  type = string
}

variable "do_image_name" {
  type    = string
  default = "ubuntu-20-04-x64"
}

variable "seed_droplet_config" {
  type = map(map(string))
}

variable "default_tags" {
  type = list(string)
}

variable "seed_user_data" {
  type    = map(string)
  default = {}
}

variable "seed_firewall" {
  type = map(map(map(string)))
  default = {
    inbound   = {}
    outbound  = {}
  }
}

variable "sentry_user_data" {
  type    = map(string)
  default = {}
}

variable "sentry_firewall" {
  type = map(map(map(string)))
  default = {
    inbound   = {}
    outbound  = {}
  }
}

variable "sentry_droplet_config" {
  type = map(map(string))
}

variable "validator_droplet_config" {
  type = map(map(string))
}

variable "validator_user_data" {
  type    = map(string)
  default = {}
}

variable "validator_firewall" {
  type    = map(map(map(string)))
  default = {
    inbound   = {}
    outbound  = {}
  }
}

variable "do_rpc_lb_config" {
  type = map(map(string))
}

variable "do_rpc_lb_algorithm" {
  type    = string
  default = "least_connections"
}

variable "do_rpc_lb_size" {
  type    = string
  default = "lb-small"
}

variable "do_rpc_health_check_port" {
  type = number
}

variable "do_rpc_health_check_protocol" {
  type = string
}

variable "do_rest_lb_config" {
  type = map(map(string))
}

variable "do_rest_lb_algorithm" {
  type    = string
  default = "least_connections"
}

variable "do_rest_lb_size" {
  type    = string
  default = "lb-small"
}

variable "do_rest_health_check_port" {
  type    = number
  default = 80
}

variable "do_rest_health_check_protocol" {
  type    = string
  default = "http"
}
