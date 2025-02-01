#!/bin/bash

uuidgen -r -x | tr -d '-' > $(pwd)/machine-id

export K3D_FIX_MOUNTS=1
export K3D_FIX_DNS=1
k3d cluster create --config cluster-config.yaml 
