data "vault_generic_secret" "do_lb_rest" {
  path = "${var.vault_secrets_path}/${var.vault_do_lb_rest_cert}"
}

data "vault_generic_secret" "do_lb_rpc" {
  path = "${var.vault_secrets_path}/${var.vault_do_lb_rpc_cert}"
}

data "vault_generic_secret" "cf_root_ca" {
  path = "${var.vault_secrets_path}/${var.vault_cf_root_ca}"
}
