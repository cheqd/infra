#!/bin/bash

set -euo pipefail
# VAULT_ADDR
# VAULT_NAMESPACE
# VAULT_TOKEN
# CHEQD_HOME
# MONIKER

show_help=false
restore=false
backup=false
NODE_KEY=$CHEQD_HOME/.cheqdnode/config/node_key.json
VALIDATOR_PRIV_KEY=$CHEQD_HOME/.cheqdnode/config/priv_validator_key.json
VALIDATOR_PRIV_STATE=$CHEQD_HOME/.cheqdnode/data/priv_validator_state.json
UPGRADE_INFO=$CHEQD_HOME/.cheqdnode/data/upgrade-info.json

while getopts b:r: flag; do
    case "${flag}" in
        b) backup=${OPTARG};;
        r) restore=${OPTARG};;
        *) show_help=true;;
    esac
done

if $restore; then
    echo "Restoring keys from Vault server. You have 10 second to cancel this (use CTRL+c)"
    sleep 10
    if [ -f "$NODE_KEY" ]; then
            echo "node_key.json is already present at path $NODE_KEY. Creating a backup instead."
            echo
            cp $NODE_KEY $NODE_KEY.bak
    fi
    if [ -f "$VALIDATOR_PRIV_KEY" ]; then
            echo "priv_validator_key.json is already present at the path $VALIDATOR_PRIV_KEY. Creating a backup instead."
            echo
            cp $VALIDATOR_PRIV_KEY $VALIDATOR_PRIV_KEY.bak
    fi
    if [ -f "$VALIDATOR_PRIV_STATE" ]; then
			echo "priv_validator_state.json is already present at the path $VALIDATOR_PRIV_STATE. Creating a backup instead."
			echo
			cp $VALIDATOR_PRIV_STATE $VALIDATOR_PRIV_STATE.bak
	fi
	if [ -f "$UPGRADE_INFO" ]; then
			echo "upgrade-info.json is already present at the path $UPGRADE_INFO. Creating a backup instead."
			echo
			cp $UPGRADE_INFO $UPGRADE_INFO.bak
	fi

	echo "Restoring node_key.json"
    vault kv get -field=passcode cheqd/$MONIKER-node-key > $NODE_KEY

	echo "Restoring priv_validator_key.json"
    vault kv get -field=passcode cheqd/$MONIKER-priv-validator-key > $VALIDATOR_PRIV_KEY

	echo "Restoring priv_validator_state.json"
	vault kv get -field=passcode cheqd/$MONIKER-priv-validator-state > $VALIDATOR_PRIV_STATE

	echo "Restoring upgrade-info.json"
	vault kv get -field=passcode cheqd/$MONIKER-upgrade-info > $UPGRADE_INFO

	echo "Done"
	exit 0
fi

if "$backup"; then
    echo "Backing up secrets to Vault server. You have 10 second to cancel this (use CTRL+c)"
    sleep 10
    vault kv put cheqd/$MONIKER-node-key passcode=@$CHEQD_HOME/.cheqdnode/config/node_key.json
    vault kv put cheqd/$MONIKER-priv-validator-key passcode=@$CHEQD_HOME/.cheqdnode/config/priv_validator_key.json
	vault kv put cheqd/$MONIKER-priv-validator-state passcode=@$CHEQD_HOME/.cheqdnode/data/priv_validator_state.json
	vault kv put cheqd/$MONIKER-upgrade-info passcode=@$CHEQD_HOME/.cheqdnode/data/upgrade-info.json
	echo "Done"
	exit 0
fi

if $show_help; then
    echo "Use -b for backup and -r for restore"
	exit 0
fi
