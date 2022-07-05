# Terraform

## Overview

Terraform code found here was written for two separate cloud providers - [DigitalOcean](https://www.digitalocean.com/) and [Hetzner](https://www.hetzner.com/). Each of these solutions stand out as a cost-efficient and reliable solutions for infrastructure management. Both of them contain configurations that were written to be as similar as possible to each other, considering different resource types that exist on both those providers.  

All the submodules include their own documentation, where both providers have the list of all the variables, which must be set before we provision our infrastructure.

Even that this code is self-sufficient, it was constructed with the idea of being utilised by [Terragrunt](../terragrunt/). It is our recommendation that it is provisioned in such manner.
