#!/bin/bash -e

if [ "$1" == "-h" ] || [ "$#" -ne 1 ]; then
  echo "Revert given vm to its last snapshot"
  echo " "
  echo "Usage: `basename $0` <vm-name>"
  exit 0
fi

#if uuid size is not 36, exit script
verify_uuid () {
  uuid=$1
  if [ ${#uuid} -ne 36 ]; then echo "error getting uuid" ; exit 1
  fi
}

vm_uuid=$(xe vm-list | grep -B 1 $1 | grep -v $1 | awk '{print $5}')
verify_uuid ${vm_uuid}

#at the moment we just get the first snapshot (or only snapshot), we should find latest one
snapshot_uuid=$(xe snapshot-list snapshot-of=${vm_uuid} | grep uuid | awk '{print $5}' | head -n 1)
verify_uuid ${snapshot_uuid}
#echo snapshot_uuid=${snapshot_uuid}
xe snapshot-revert uuid=${snapshot_uuid}
xe vm-start vm=$1
