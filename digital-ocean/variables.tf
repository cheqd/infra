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

variable "seeds_droplet_config" {
  type = map(map(string))
}

variable "default_tags" {
  type = map(string)
}

variable "seeds_user_data" {
  type = map(string)
}

variable "seeds_firewall" {
  type = map(map(map(string)))
}

variable "sentry_user_data" {
  type = map(string)
}

variable "sentries_firewall" {
  type = map(map(map(string)))
}

variable "sentries_droplet_config" {
  type = map(map(string))
}
