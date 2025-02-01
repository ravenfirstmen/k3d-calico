#!/usr/bin/env bash

CALICO_VERSION="v3.28.0"

TARGET_FILE="$(pwd)/charts/calico.yaml"

wget -q --show-progress "https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/tigera-operator.yaml" -O "${TARGET_FILE}"

# based on https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/custom-resources.yaml
# explicit configure calico instalation with
# the cidr block is k3s defaults: https://docs.k3s.io/cli/server#networking  
# node this cidr should be the same when starting the clustr with --cluster-cidr
cat<<'EOT' >> "${TARGET_FILE}"
---
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  kubernetesProvider: ""
  cni:
    type: Calico
    ipam:
      type: Calico
  calicoNetwork:
    bgp: Enabled
    containerIPForwarding: Enabled
    ipPools:
    - cidr: 10.42.0.0/16
      encapsulation: VXLANCrossSubnet
      natOutgoing: Enabled
      nodeSelector: all()      
      disableBGPExport: false
---
apiVersion: operator.tigera.io/v1
kind: APIServer
metadata:
  name: default
spec: {}
EOT
