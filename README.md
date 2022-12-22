# DevOps & Automation Tooling for cheqd

[![GitHub license](https://img.shields.io/github/license/cheqd/infra?color=blue&style=flat-square)](https://github.com/cheqd/infra/blob/main/LICENSE) [![GitHub contributors](https://img.shields.io/github/contributors/cheqd/infra?label=contributors%20%E2%9D%A4%EF%B8%8F&style=flat-square)](https://github.com/cheqd/infra/graphs/contributors)

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/cheqd/infra/dispatch.yml?label=workflows&style=flat-square)](https://github.com/cheqd/infra/actions/workflows/dispatch.yml) ![GitHub repo size](https://img.shields.io/github/repo-size/cheqd/infra?style=flat-square)

The goal of this project is to make infrastructure provisioning and configuration dead simple for [cheqd network](https://github.com/cheqd/cheqd-node).

## Objectives

We aim to make DevOps and automation for cheqd network simpler by accelerating the following:

### Infrastructure provisioning

This is how we create secure private networks, firewalls, storage systems, volume mounting, static IP allocation, CPU and memory allocation among other things across multiple cloud platforms.

Currently we support [DigitalOcean](https://www.digitalocean.com/) and [Hetzner](https://www.hetzner.com/). We chose to implement this tooling on these providers since they offer a good balance between cost vs performance for running cheqd nodes. However, our Terragrunt configuration (described below) can be used to generate Terraform for other cloud providers as well.

### Node configuration

For configuring our nodes, we use Ansible, an open source and free configuration management tool. We use Ansible for running our [seed](https://docs.tendermint.com/master/spec/p2p/node.html#seeds), [sentry](https://docs.tendermint.com/master/spec/p2p/node.html#sentry-node), and [validator nodes](https://docs.tendermint.com/v0.34/tendermint-core/validators.html). We also use it for installing any debugging packages, setting up logs and metrics collection using [Datadog](https://www.datadoghq.com/).

## Pre-Requisites

### Terraform

[Terraform](https://www.terraform.io/downloads) is an open-source infrastructure as code software tool that enables you to safely and predictably create, change, and improve infrastructure. Being de facto the industry standard Infrastructure as Code tool, it is our pick for infrastructure provisioning.  
Code located in its [respective directory](terraform/) can be used to provision the necessary infrastructure for DigitalOcean and Hetzner cloud providers.

### Terragrunt

[Terragrunt](https://terragrunt.gruntwork.io/) is a thin wrapper for Terraform that provides extra tools for keeping Terraform configurations DRY (don't repeat yourself).  

We've utilised this tool to keep the Terraform code clean. Examples and further details can be found in its [own directory](terragrunt/).

### Ansible

[Ansible](https://www.ansible.com/) is an open source community project sponsored by Red Hat. Our [Ansible scripts](scripts/) directory contains various configuration files and scripts that one might find useful. There is no one tool this directory pertains to, but should rather be seen as a collective place for a variety of technologies.

## Configuration

All the sub-modules include their own documentation, like `terraform/digital-ocean` has the list of all the variables, which must be set before we provision our infrastructure.

## Repository breakdown

```text
.
├── ansible
└── terraform
    ├── digital-ocean
    └── hetzner
```

## 🐞 Bug reports & 🤔 feature requests

If you notice anything not behaving how you expected, or would like to make a suggestion / request for a new feature, please create a [**new issue**](https://github.com/cheqd/infra/issues/new/choose) and let us know.

## 💬 Community

The [**cheqd Community Slack**](http://cheqd.link/join-cheqd-slack) is our primary chat channel for the open-source community, software developers, and node operators.

Please reach out to us there for discussions, help, and feedback on the project.

## 🙋 Find us elsewhere

[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/cheqd) [![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](http://cheqd.link/discord-github) [![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/intent/follow?screen_name=cheqd_io) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](http://cheqd.link/linkedin) [![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white)](http://cheqd.link/join-cheqd-slack) [![Medium](https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white)](https://blog.cheqd.io) [![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCBUGvvH6t3BAYo5u41hJPzw/)
