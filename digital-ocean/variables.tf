variable "do_token" {
  type = string
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
  type = map(string)
}

variable "seed_firewall" {
  type = map(map(map(string)))
}

variable "sentry_user_data" {
  type = map(string)
}

variable "sentry_firewall" {
  type = map(map(map(string)))
}

variable "sentry_droplet_config" {
  type = map(map(string))
}

variable "validator_droplet_config" {
  type = map(map(string))
}

variable "validator_user_data" {
  type = map(string)
}

variable "validator_firewall" {
  type = map(map(map(string)))
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

variable "do_api_lb_config" {
  type = map(map(string))
}

variable "do_api_lb_algorithm" {
  type    = string
  default = "least_connections"
}

variable "do_api_lb_size" {
  type    = string
  default = "lb-small"
}

variable "do_api_health_check_port" {
  type = number
}

variable "do_api_health_check_protocol" {
  type = string
}

variable "vault_do_lb_wildcard_cert" {
  description = "Vault Key for pre-generated key pairs of cloudflare origin certificates"
  type        = string
}

variable "vault_secrets_path" {
  description = "Vault Path at which the secrets are stored"
  type        = string
}

variable "vault_cf_root_ca" {
  type    = string
  default = "cloudflare_root_ca"
}
