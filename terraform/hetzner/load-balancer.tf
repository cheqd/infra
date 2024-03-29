# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer Certificates
# ----------------------------------------------------------------------------------------------------------------------
data "hcloud_certificate" "cheqd" {
  name = "${var.network}-certificate"
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer - RPC
# ----------------------------------------------------------------------------------------------------------------------
resource "hcloud_load_balancer" "rpc_lb" {
  name               = "${var.network}-rpc-lb"
  load_balancer_type = var.hetzner_lb_type
  location           = var.hetzner_region
  algorithm {
    type = "least_connections"
  }

  labels = {
    "Terraform" = "True"
    "Network"   = var.network
  }
}

resource "hcloud_load_balancer_network" "rpc_lb" {
  load_balancer_id = hcloud_load_balancer.rpc_lb.id
  subnet_id        = hcloud_network_subnet.rpc_lb.id
  ip               = trimsuffix(cidrsubnet(hcloud_network_subnet.rpc_lb.ip_range, 8, 51), "/32")
}

resource "hcloud_load_balancer_service" "rpc_lb" {
  load_balancer_id = hcloud_load_balancer.rpc_lb.id
  protocol         = "https"
  listen_port      = "443"
  destination_port = "26657"

  http {
    sticky_sessions = true
    redirect_http   = true
    certificates    = [data.hcloud_certificate.cheqd.id]
  }

  health_check {
    interval = 10
    port     = 26657
    protocol = "http"
    timeout  = 5
    retries  = 3
    http {
      path         = "/status"
      status_codes = ["200"]
      response     = "false"
    }
  }
}

resource "hcloud_load_balancer_target" "rpc_lb_sentry" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rpc_lb.id
  label_selector   = "NodeType=sentry"
  use_private_ip   = true
}

# ----------------------------------------------------------------------------------------------------------------------
# Load Balancer - Rest
# ----------------------------------------------------------------------------------------------------------------------
resource "hcloud_load_balancer" "rest_lb" {
  name               = "${var.network}-rest-lb"
  load_balancer_type = var.hetzner_lb_type
  location           = var.hetzner_region
  algorithm {
    type = "least_connections"
  }

  labels = {
    "Terraform" = "True"
    "Network"   = var.network
  }
}

resource "hcloud_load_balancer_network" "rest_lb" {
  load_balancer_id = hcloud_load_balancer.rest_lb.id
  subnet_id        = hcloud_network_subnet.rest_lb.id
  ip               = trimsuffix(cidrsubnet(hcloud_network_subnet.rest_lb.ip_range, 8, 51), "/32")
}

resource "hcloud_load_balancer_service" "rest_lb" {
  load_balancer_id = hcloud_load_balancer.rest_lb.id
  protocol         = "https"
  listen_port      = "443"
  destination_port = "1317"

  http {
    sticky_sessions = true
    redirect_http   = true
    certificates    = [data.hcloud_certificate.cheqd.id]
  }

  health_check {
    interval = 10
    port     = 1317
    protocol = "http"
    timeout  = 5
    retries  = 3
    http {
      path         = "/cosmos/base/tendermint/v1beta1/syncing"
      status_codes = ["200"]
      response     = "false"
    }
  }
}

resource "hcloud_load_balancer_target" "rest_lb_sentry" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rest_lb.id
  label_selector   = "NodeType=sentry"
  use_private_ip   = true
}
