# cheqd-infra

## Description

## Ansible variables
In order to control the behaviour of ansible playbook and specify desired configuration of your node(s), you can define some variables in cheqd-node.yml file. Here is the list of required, optional and default variables, which can be overriden to change default confiuration:

* **network** - Choose network. The options are *mainnet* and *testnet*. ***Required**
* **moniker** - A custom human readable name for your node. ***Required**
* **sentry_id** - If you already have a sentry node up and running, enter its id here.
* **validator_id** - If you already have a validator node up and running, enter its id here.
* **seed_id** - If you already have a seed node up and running, enter its id here.
* **new_account** - If you already have sentry, validator or seed node up and running, set this to false. If you are deploying node(s) from scratch, set this to true. Default is *true*.
* **log_level** - Specifies log verbosity. Default is *error*. 
* **prometheus_enabled** - Specifies if your node(s) are going to export prometheus metrics. Default is *false*.
* **p2p_port** - Specifies the port your nodes are going to use for communcation with other peers. Default is *25556*.
* **domain** - A fully qualified domain name for your node. Optional, default is *inventory hostname*.
* **version** - Choose the latest version from [here](https://github.com/cheqd/cheqd-node/releases). The default version is [here](./ansible/roles/cheqd/defaults/main.yml)
* **enable_rpc_endpoint_externally** - Choose whether to enable public RPC endpoints. Default is *true*.
