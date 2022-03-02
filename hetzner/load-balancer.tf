resource "hcloud_uploaded_certificate" "rpc" {
  name        = "${var.network}-cf-rpc-cert"
  private_key = data.vault_generic_secret.hcloud_rpc.data["priv_key"]
  certificate = data.vault_generic_secret.hcloud_rpc.data["csr"]

  labels = {
    "Terraform"   = "True"
    "Network"     = var.network
    "Environment" = var.environment
  }
}

resource "hcloud_uploaded_certificate" "api" {
  name        = "${var.network}-cf-api-cert"
  private_key = data.vault_generic_secret.hcloud_api.data["priv_key"]
  certificate = data.vault_generic_secret.hcloud_api.data["csr"]

  labels = {
    "Terraform"   = "True"
    "Network"     = var.network
    "Environment" = var.environment
  }
}

resource "hcloud_load_balancer" "rpc_lb" {
  name               = "cheqd-${var.network}-rpc-lb"
  load_balancer_type = var.hetzner_lb_type
  location           = var.hetzner_region
  algorithm {
    type = "least_connections"
  }

  labels = {
    "Terraform"   = "True"
    "Network"     = var.network
    "Environment" = var.environment
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
    certificates    = [hcloud_uploaded_certificate.rpc.id]
  }

  health_check {
    interval = 10
    port     = 26657
    protocol = "http"
    timeout  = 5
    retries  = 3
    http {
      path         = "/health"
      status_codes = ["2??"]
    }
  }
}

resource "hcloud_load_balancer_target" "rpc_lb_seed" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rpc_lb.id
  label_selector   = "NodeType=seed"
}

resource "hcloud_load_balancer_target" "rpc_lb_sentry" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rpc_lb.id
  label_selector   = "NodeType=sentry"
}

resource "hcloud_load_balancer" "rest_lb" {
  name               = "cheqd-${var.network}-rest-lb"
  load_balancer_type = var.hetzner_lb_type
  location           = var.hetzner_region
  algorithm {
    type = "least_connections"
  }

  labels = {
    "Terraform"   = "True"
    "Network"     = var.network
    "Environment" = var.environment
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
    certificates    = [hcloud_uploaded_certificate.rest.id]
  }

  health_check {
    interval = 10
    port     = 1317
    protocol = "http"
    timeout  = 5
    retries  = 3
    http {
      path         = "/node_info"
      status_codes = ["2??", "3??"]
    }
  }
}

resource "hcloud_load_balancer_target" "rest_lb_seed" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rest_lb.id
  label_selector   = "NodeType=seed"
}

resource "hcloud_load_balancer_target" "rest_lb_sentry" {
  type             = "label_selector"
  load_balancer_id = hcloud_load_balancer.rest_lb.id
  label_selector   = "NodeType=sentry"
}
