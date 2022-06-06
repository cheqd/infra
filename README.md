# ℹ️ Overview

The goal of this project is to make infrastructure provisioning and configuration dead simple for Cheqd Network. This
project is leargely divided into two parts:
- Infrastructure provisioning
	This is how we create secure private networks, firewalls, storage systems, volume mounting, static IP allocation,
	CPU and memory allocation among other things across multiple cloud platforms. Currently we support Digital Ocean
	and Hetzner.
- Node configuration
	For configuring our nodes, we use Ansible, an open source and free configuration management tool. We use Ansible for
	running our Seed, Sentry or Validator modes, installing any debugging packages, setting up logs and metrics
	collection.

## 🔧 Pre-requisite

Before you start using this tooling, please make sure you have the following tools installed:
- Terraform - [download link](https://www.terraform.io/downloads)
- Terragrunt - [download link](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- Ansible - [download link](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## 🧬 Project structure

```
.
├── ansible
└── terraform
    ├── digital-ocean
    └── hetzner
```

All the sub-modules include their own documentation, like `terraform/digital-ocean` has the list of all the 
variables, which must be set before we provision our infrastructure.
