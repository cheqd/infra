data "vault_generic_secret" "hcloud_rpc" {
  path = "${var.vault_secrets_path}/${var.vault_hcloud_rpc_cert}"
}

data "vault_generic_secret" "hcloud_rest" {
  path = "${var.vault_secrets_path}/${var.vault_hcloud_rest_cert}"
}

data "vault_generic_secret" "cf_root_ca" {
  path = "${var.vault_secrets_path}/${var.vault_cf_root_ca}"
}
