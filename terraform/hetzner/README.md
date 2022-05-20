<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.32.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.32.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_floating_ip.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/floating_ip) | resource |
| [hcloud_floating_ip.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/floating_ip) | resource |
| [hcloud_floating_ip.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/floating_ip) | resource |
| [hcloud_load_balancer.grpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer.rest_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer.rpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer_network.grpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_network.rest_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_network.rpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_service.grpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_service) | resource |
| [hcloud_load_balancer_service.rest_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_service) | resource |
| [hcloud_load_balancer_service.rpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_service) | resource |
| [hcloud_load_balancer_target.grpc_lb_seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_load_balancer_target.grpc_lb_sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_load_balancer_target.rest_lb_seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_load_balancer_target.rest_lb_sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_load_balancer_target.rpc_lb_seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_load_balancer_target.rpc_lb_sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_network.cheqd_network](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_subnet.grpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.rest_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.rpc_lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_placement_group.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/placement_group) | resource |
| [hcloud_placement_group.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/placement_group) | resource |
| [hcloud_placement_group.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/placement_group) | resource |
| [hcloud_server.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_volume.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume) | resource |
| [hcloud_volume.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume) | resource |
| [hcloud_volume.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume) | resource |
| [hcloud_volume_attachment.seed](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment) | resource |
| [hcloud_volume_attachment.sentry](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment) | resource |
| [hcloud_volume_attachment.validator](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment) | resource |
| [hcloud_certificate.cheqd](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/certificate) | data source |
| [hcloud_ssh_key.cheqd](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Authentication token for Hetzner. | `string` | n/a | yes |
| <a name="input_hetzner_image_name"></a> [hetzner\_image\_name](#input\_hetzner\_image\_name) | Desired OS to be installed on servers. | `string` | `"ubuntu-20.04"` | no |
| <a name="input_hetzner_lb_type"></a> [hetzner\_lb\_type](#input\_hetzner\_lb\_type) | Type of the Hetzner's Load Balancer/ | `string` | `"lb11"` | no |
| <a name="input_hetzner_network_ip_range"></a> [hetzner\_network\_ip\_range](#input\_hetzner\_network\_ip\_range) | Hezner VPC/Network IP range in CIDR notation. | `string` | n/a | yes |
| <a name="input_hetzner_region"></a> [hetzner\_region](#input\_hetzner\_region) | Hetzner dedicated region for resources to be provisioned in. | `string` | n/a | yes |
| <a name="input_hetzner_zone"></a> [hetzner\_zone](#input\_hetzner\_zone) | Hetzner zone for network subnets. Can be one of 'eu-central' or 'us-east'. | `string` | `"eu-central"` | no |
| <a name="input_network"></a> [network](#input\_network) | Hetzner VPC/Network name. | `string` | n/a | yes |
| <a name="input_seed_firewall"></a> [seed\_firewall](#input\_seed\_firewall) | Firewall rules for seed servers. | `map(map(map(string)))` | <pre>{<br>  "inbound": {},<br>  "outbound": {}<br>}</pre> | no |
| <a name="input_seed_server_config"></a> [seed\_server\_config](#input\_seed\_server\_config) | Custom configuration for seed servers. | `map(map(string))` | n/a | yes |
| <a name="input_seed_user_data"></a> [seed\_user\_data](#input\_seed\_user\_data) | User data to be applied on server boot for seed servers. | `map(string)` | `{}` | no |
| <a name="input_sentry_firewall"></a> [sentry\_firewall](#input\_sentry\_firewall) | Firewall rules for sentry servers. | `map(map(map(string)))` | <pre>{<br>  "inbound": {},<br>  "outbound": {}<br>}</pre> | no |
| <a name="input_sentry_server_config"></a> [sentry\_server\_config](#input\_sentry\_server\_config) | Custom configuration for seed servers. | `map(map(string))` | n/a | yes |
| <a name="input_sentry_user_data"></a> [sentry\_user\_data](#input\_sentry\_user\_data) | User data to be applied on server boot for sentry servers. | `map(string)` | `{}` | no |
| <a name="input_validator_firewall"></a> [validator\_firewall](#input\_validator\_firewall) | Firewall rules for validator servers. | `map(map(map(string)))` | <pre>{<br>  "inbound": {},<br>  "outbound": {}<br>}</pre> | no |
| <a name="input_validator_server_config"></a> [validator\_server\_config](#input\_validator\_server\_config) | Custom configuration for validator servers. | `map(map(string))` | n/a | yes |
| <a name="input_validator_user_data"></a> [validator\_user\_data](#input\_validator\_user\_data) | User data to be applied on server boot for validator servers. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_seed_floating_ip"></a> [seed\_floating\_ip](#output\_seed\_floating\_ip) | Set of Hetzner Floating IPs used by seed nodes |
| <a name="output_seed_servers"></a> [seed\_servers](#output\_seed\_servers) | Set of seed nodes running on Hetzner Cloud |
| <a name="output_seed_volumes"></a> [seed\_volumes](#output\_seed\_volumes) | Set of volumes used by seed nodes |
| <a name="output_seeds_firewall"></a> [seeds\_firewall](#output\_seeds\_firewall) | This firewall is used to restrict inbound/outbound traffic for seed nodes |
| <a name="output_sentries_firewall"></a> [sentries\_firewall](#output\_sentries\_firewall) | This firewall is used to restrict inbound/outbound traffic for sentry nodes |
| <a name="output_sentry_floating_ip"></a> [sentry\_floating\_ip](#output\_sentry\_floating\_ip) | Set of Hetzner Floating IPs used by sentry nodes |
| <a name="output_sentry_servers"></a> [sentry\_servers](#output\_sentry\_servers) | Set of sentry nodes running on Hetzner Cloud |
| <a name="output_sentry_volumes"></a> [sentry\_volumes](#output\_sentry\_volumes) | Set of volumes used by sentry nodes |
| <a name="output_server_ips"></a> [server\_ips](#output\_server\_ips) | This is a Set of all server IPs (Seeds, Sentries, and Validators) with key as node name (like seed1-ap-mainnet) and their value the IPv4 Address of the node. This is useful for doing easy DNS mapping using a for\_each |
| <a name="output_validator_floating_ip"></a> [validator\_floating\_ip](#output\_validator\_floating\_ip) | Set of Hetzner Floating IPs used by validator nodes |
| <a name="output_validator_servers"></a> [validator\_servers](#output\_validator\_servers) | Set of Validator nodes running on Hetzner Cloud |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Private Network for the entire fleet of services running on Hetzner Cloud |
<!-- END_TF_DOCS -->