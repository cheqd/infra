# Terraform for DigitalOcean deploys

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.17.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.17.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.seed](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_droplet.sentry](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_droplet.validator](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.node-developer](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_firewall.node-public](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_firewall.node-restricted](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_floating_ip.seed](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip) | resource |
| [digitalocean_floating_ip.sentry](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip) | resource |
| [digitalocean_floating_ip.validator](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip) | resource |
| [digitalocean_loadbalancer.rest_lb](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer) | resource |
| [digitalocean_loadbalancer.rpc_lb](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer) | resource |
| [digitalocean_volume.seed_volumes](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume.sentry_volumes](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume.validator_volumes](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume_attachment.seed](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_volume_attachment.sentry](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_volume_attachment.validator](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_vpc.cheqd_network](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [digitalocean_certificate.cheqd](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/certificate) | data source |
| [digitalocean_ssh_key.cheqd](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags to be applied to all available resources. | `list(string)` | n/a | yes |
| <a name="input_do_image_name"></a> [do\_image\_name](#input\_do\_image\_name) | Desired OS to be installed on servers. | `string` | `"ubuntu-20-04-x64"` | no |
| <a name="input_do_network_ip_range"></a> [do\_network\_ip\_range](#input\_do\_network\_ip\_range) | DigitalOcean VPC/Network IP range in CIDR notation. | `string` | n/a | yes |
| <a name="input_do_region"></a> [do\_region](#input\_do\_region) | DigitalOcean Region | `string` | n/a | yes |
| <a name="input_do_rest_health_check_port"></a> [do\_rest\_health\_check\_port](#input\_do\_rest\_health\_check\_port) | Target port that the Rest Load Balancer will perform health checks. | `number` | `80` | no |
| <a name="input_do_rest_health_check_protocol"></a> [do\_rest\_health\_check\_protocol](#input\_do\_rest\_health\_check\_protocol) | Protocol that the Rest Load Balancer will use for health checks. | `string` | `"http"` | no |
| <a name="input_do_rest_lb_algorithm"></a> [do\_rest\_lb\_algorithm](#input\_do\_rest\_lb\_algorithm) | Rest Load Balancer algorithm to be used. | `string` | `"least_connections"` | no |
| <a name="input_do_rest_lb_config"></a> [do\_rest\_lb\_config](#input\_do\_rest\_lb\_config) | Rest Load Balancer configuration. | `map(map(string))` | n/a | yes |
| <a name="input_do_rest_lb_size"></a> [do\_rest\_lb\_size](#input\_do\_rest\_lb\_size) | Rest Load Balancer type/size. | `string` | `"lb-small"` | no |
| <a name="input_do_rpc_health_check_port"></a> [do\_rpc\_health\_check\_port](#input\_do\_rpc\_health\_check\_port) | Target port that the RPC Load Balancer will perform health checks. | `number` | n/a | yes |
| <a name="input_do_rpc_health_check_protocol"></a> [do\_rpc\_health\_check\_protocol](#input\_do\_rpc\_health\_check\_protocol) | Protocol that the RPC Load Balancer will use for health checks. | `string` | n/a | yes |
| <a name="input_do_rpc_lb_algorithm"></a> [do\_rpc\_lb\_algorithm](#input\_do\_rpc\_lb\_algorithm) | RPC Load Balancer algorithm to be used. | `string` | `"least_connections"` | no |
| <a name="input_do_rpc_lb_config"></a> [do\_rpc\_lb\_config](#input\_do\_rpc\_lb\_config) | RPC Load Balancer configuration. | `map(map(string))` | n/a | yes |
| <a name="input_do_rpc_lb_size"></a> [do\_rpc\_lb\_size](#input\_do\_rpc\_lb\_size) | RPC Load Balancer type/size. | `string` | `"lb-small"` | no |
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | Authentication token for DigitalOcean. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | DigitalOcean VPC/Network name | `string` | n/a | yes |
| <a name="input_node_firewall_developer"></a> [node\_firewall\_developer](#input\_node\_firewall\_developer) | Developer firewall rules for debugging purposes. | `map(map(map(string)))` | <pre>{<br>  "inbound": {},<br>  "outbound": {}<br>}</pre> | no |
| <a name="input_node_firewall_public"></a> [node\_firewall\_public](#input\_node\_firewall\_public) | Common firewall rules for public traffic. | `map(map(map(string)))` | <pre>{<br>  "inbound": {},<br>  "outbound": {}<br>}</pre> | no |
| <a name="input_node_firewall_restricted"></a> [node\_firewall\_restricted](#input\_node\_firewall\_restricted) | Common firewall rules for restricted traffic. | `map(map(map(string)))` | <pre>{<br>  "inbound": {},<br>  "outbound": {}<br>}</pre> | no |
| <a name="input_seed_droplet_config"></a> [seed\_droplet\_config](#input\_seed\_droplet\_config) | Custom configuration for seed servers. | `map(map(string))` | n/a | yes |
| <a name="input_seed_user_data"></a> [seed\_user\_data](#input\_seed\_user\_data) | User data to be applied on server boot for seed servers. | `map(string)` | `{}` | no |
| <a name="input_sentry_droplet_config"></a> [sentry\_droplet\_config](#input\_sentry\_droplet\_config) | Custom configuration for sentry servers. | `map(map(string))` | n/a | yes |
| <a name="input_sentry_user_data"></a> [sentry\_user\_data](#input\_sentry\_user\_data) | User data to be applied on server boot for sentry servers. | `map(string)` | `{}` | no |
| <a name="input_validator_droplet_config"></a> [validator\_droplet\_config](#input\_validator\_droplet\_config) | Custom configuration for validator servers. | `map(map(string))` | n/a | yes |
| <a name="input_validator_user_data"></a> [validator\_user\_data](#input\_validator\_user\_data) | User data to be applied on server boot for validator servers. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_node_developer"></a> [node\_developer](#output\_node\_developer) | This firewall (managed by Cloud Provider) is used to restrict inbound/outbound developer(testing)traffic |
| <a name="output_node_public"></a> [node\_public](#output\_node\_public) | This firewall (managed by Cloud Provider) is used to restrict inbound/outbound public traffic |
| <a name="output_node_restricted"></a> [node\_restricted](#output\_node\_restricted) | This firewall is used to restrict inbound/outbound restricted(internal) traffic |
| <a name="output_seed_droplets"></a> [seed\_droplets](#output\_seed\_droplets) | Set of seed nodes running on DigitalOcean |
| <a name="output_seed_floating_ip"></a> [seed\_floating\_ip](#output\_seed\_floating\_ip) | Set of DigitalOcean Floating IPs used by seed nodes |
| <a name="output_seed_volumes"></a> [seed\_volumes](#output\_seed\_volumes) | Set of volumes used by seed nodes |
| <a name="output_sentry_droplets"></a> [sentry\_droplets](#output\_sentry\_droplets) | Set of sentry nodes running on DigitalOcean |
| <a name="output_sentry_floating_ip"></a> [sentry\_floating\_ip](#output\_sentry\_floating\_ip) | Set of DigitalOcean Floating IPs used by sentry nodes |
| <a name="output_sentry_volumes"></a> [sentry\_volumes](#output\_sentry\_volumes) | Set of volumes used by sentry nodes |
| <a name="output_server_ips"></a> [server\_ips](#output\_server\_ips) | This is a Set of all server IPs (Seeds, Sentries, and Validators) with key as node name (like seed1-ap-mainnet) and their value the IPv4 Address of the node. This is useful for DNS mapping using a for\_each |
| <a name="output_validator_droplets"></a> [validator\_droplets](#output\_validator\_droplets) | Set of Validator nodes running on DigitalOcean |
| <a name="output_validator_floating_ip"></a> [validator\_floating\_ip](#output\_validator\_floating\_ip) | Set of DigitalOcean Floating IPs used by validator nodes |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Private Network for the entire fleet of services running on DigitalOcean |
<!-- END_TF_DOCS -->