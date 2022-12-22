#!/bin/bash

set -euo pipefail

CHAIN_ID="cheqd-testnet-4"      # For the mainnet, use cheqd-mainnet-1
SNAP_PATH="/snapshots"
CHEQD_ROOT_DIR="/home/cheqd/.cheqdnode"   # Top-level path for cheqd node, NOT the direct path to data folder
SERVICE_NAME="cheqd-cosmovisor.service"
RPC_ADDRESS="http://localhost:26657"
TIME_STAMP=$(date +%Y-%m-%d)
SNAP_NAME="${CHAIN_ID}_${TIME_STAMP}.tar.lz4"
LOG_PATH="${SNAP_PATH}/snapshot_log.txt"
BACKUP_BUCKET_PATH="s3://cheqd-node-backups/testnet"     # For the mainnet, use s3://cheqd-node-backups/mainnet

now_date() {
        echo -n "$(date '+%Y-%m-%d_%H:%M:%S')"
}

log_this() {
        #YEL='\033[1;33m' # yellow
        #NC='\033[0m'     # No Color
        local logging="$*"
        printf "|%s| $logging\n" "$(now_date)" | tee -a ${LOG_PATH}
}

CHAIN_UP_TO_DATE=$(curl -s localhost:26657/status | jq -r '.result.sync_info.catching_up')
while ${CHAIN_UP_TO_DATE}
  do log_this "Sleeping for 10 minutes, chaining is syncing up"; sleep 600; CHAIN_UP_TO_DATE=$(curl -s localhost:26657/status | jq -r '.result.sync_info.catching_up')
done

LAST_BLOCK_HEIGHT=$(curl -s ${RPC_ADDRESS}/status | jq -r .result.sync_info.latest_block_height)
log_this "LAST_BLOCK_HEIGHT ${LAST_BLOCK_HEIGHT}"

log_this "Stopping ${SERVICE_NAME}"
sudo systemctl stop ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Creating new snapshot"
sudo time tar --use-compress-program=lz4 -cvf "${SNAP_PATH}"/"${SNAP_NAME}" -C "${CHEQD_ROOT_DIR}" data/ | sudo tee -a "${LOG_PATH}"

log_this "Starting ${SERVICE_NAME}"
sudo systemctl start ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Generating Checksums"
sha256sum "${SNAP_PATH}"/"${SNAP_NAME}" > "${SNAP_PATH}"/sha256sum.txt
md5sum "${SNAP_PATH}"/"${SNAP_NAME}" > "${SNAP_PATH}"/md5sum.txt

log_this "Syncing tarball to S3"
s3cmd put "${SNAP_PATH}"/"${SNAP_NAME}" "${BACKUP_BUCKET_PATH}"/"${TIME_STAMP}"/"${SNAP_NAME}" | sudo tee -a "${LOG_PATH}"
s3cmd put "${SNAP_PATH}"/sha256sum.txt "${BACKUP_BUCKET_PATH}"/"${TIME_STAMP}"/sha256sum.txt &>>"${LOG_PATH}"
s3cmd put "${SNAP_PATH}"/md5sum.txt "${BACKUP_BUCKET_PATH}"/"${TIME_STAMP}"/md5sum.txt &>>"${LOG_PATH}"
s3cmd setacl "${BACKUP_BUCKET_PATH}" --acl-public --recursive

log_this "Removing old snapshot(s):"
cd ${SNAP_PATH}
rm -fv "${SNAP_NAME}" &>>${LOG_PATH}
rm -fv sha256sum.txt md5sum.txt &>>${LOG_PATH}

obj_count=$(s3cmd ls ${BACKUP_BUCKET_PATH}/ | wc -l)
del_count=$((obj_count-4))

log_this "Found ${del_count} old snapshots out of ${obj_count} total snapshots in the S3 bucket." 

if [ "${obj_count}" -gt 4 ]; then
    log_this "Removing old snapshots from the bucket."
    s3cmd ls ${BACKUP_BUCKET_PATH}/ | awk '{print $2}' | head -${del_count} | xargs -n 1 -I {} -t s3cmd rm --recursive {} &>>${LOG_PATH}
else
    log_this "Nothing to delete from the bucket." 
fi

du -hs ${SNAP_PATH} | tee -a ${LOG_PATH}
log_this "Done\n---------------------------\n"
