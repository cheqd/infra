resource "digitalocean_certificate" "cheqd" {
  name = "${var.network}-custom-lb-cert"
  type = "custom"

  private_key       = var.tls_cert_priv_key
  leaf_certificate  = cloudflare_origin_ca_certificate.cheqd.certificate
  certificate_chain = data.cloudflare_origin_ca_root_certificate.cf_origin_ca.cert_pem
}

data "cloudflare_origin_ca_root_certificate" "cf_origin_ca" {
  algorithm = "ecc"
}
