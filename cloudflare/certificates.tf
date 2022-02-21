resource "tls_cert_request" "cheqd" {
  key_algorithm   = var.tls_cert_algo
  private_key_pem = var.tls_cert_priv_key

  subject {
    common_name  = var.cf_domain
    organization = "Cheqd Network"
  }
}

resource "cloudflare_origin_ca_certificate" "cheqd" {
  csr                = tls_cert_request.cheqd.cert_request_pem
  hostnames          = [var.cf_domain]
  request_type       = "origin-ecc"
  requested_validity = 5475
}
