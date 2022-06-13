# Terragrunt

[WIP]
## Overview

Terragrunt code found here is written on top of the underlying [Terraform](../terraform/) configuration.  
It will provision the following resources for the corresponding cloud provider.  

## How To

### Prerequisites

Provisioning load balancers require that there is a certificate named `cheqd` already present in DigitalOcean and Hetzner (in such situations where both of them will be used).
The requirement is set by HTTPS (port 443) listeners needing to have a certificate for the encrypted TLS connection.

### Steps

Clone the repository  
`git clone https://github.com/cheqd/infra`  

If you wish to utilise Hetzner as the infrastructure provider, go to the [corresponding directory](./mainnet/hetzner/).  
Alternatively, go to the [DigitalOcean directory](./mainnet/digital-ocean/).  

Run `terragrunt init`.  
Run `terragrunt plan` to view all of the resources that will be created.  
Run `terragrunt apply` to create the resources.  

Alternatively, `run-all` (`terragrunt run-all init`, `terragrunt run-all plan`, `terragrunt run-all apply`)
can be used to provision resources for both providers from the [mainnet](./mainnet/) directory.

## Resources

Provided Terragrunt code is the end-to-end configuration for the entire infrastructure. It includes the following:
- Seed node
- Sentry node
- Validator node
- RPC load balancer
- REST load balancer  

_Note: Additional resources will be created, which include the appropriate network and firewall rules._

### DigitalOcean

The example code is located [at the following path](./mainnet/digital-ocean/terragrunt.hcl).  
This will provision the aforementioned resources in the AMS3 region. Instance type for nodes will be `Basic Intel 8GB/4vCPUs/160GB`,
where the values represent RAM/CPU/Storage respectively.  

### Hetzner

The example code is located [at the following path](./mainnet/hetzner/terragrunt.hcl).  
This will provision the aforementioned resources in the EU(nbg1) region. Instance type for nodes will be `CPX31 8GB/4vCPUs/160GB`,
where the values represent RAM/CPU/Storage respectively.
