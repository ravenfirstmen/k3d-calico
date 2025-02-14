#!/bin/bash

uuidgen -r -x | tr -d '-' > $(pwd)/machine-id

export K3D_FIX_MOUNTS=1
export K3D_FIX_DNS=1
if k3d cluster create --config cluster-config.yaml 2>&1; then
    ./gen-tls-certs.sh  
fi