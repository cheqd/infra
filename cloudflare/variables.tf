variable "cf_email" {
  type = string
}

variable "cf_api_key" {
  type = string
}

variable "cf_domain" {
  type = string
}

variable "network" {
  type = string
}

variable "region" {
  type = string
}

variable "api_user_service_key" {
  type = string
}

variable "tls_cert_algo" {
  type    = string
  default = "ECDSA"
}

variable "tls_cert_priv_key" {
  type      = string
  sensitive = true
}

variable "tls_cert_pub_key" {
  type = string
}

variable "do_token" {
  type = string
}

variable "cf_access_ssh_locations" {
  type = list(string)
}

variable "cf_access_gsuite_emails" {
  type = list(string)
}
