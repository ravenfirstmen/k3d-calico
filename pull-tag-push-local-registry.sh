#!/bin/bash

export REGISTRY="k3d-registry.localhost:5000"

docker pull quay.io/tigera/operator:v1.32.7
docker pull calico/typha:v3.27.3
docker pull calico/ctl:v3.27.3
docker pull calico/node:v3.27.3
docker pull calico/cni:v3.27.3
docker pull calico/apiserver:v3.27.3
docker pull calico/kube-controllers:v3.27.3
docker pull calico/dikastes:v3.27.3
docker pull calico/pod2daemon-flexvol:v3.27.3
docker pull calico/csi:v3.27.3
docker pull calico/node-driver-registrar:v3.27.3

docker tag quay.io/tigera/operator:v1.32.7 $REGISTRY/tigera/operator:v1.32.7
docker tag calico/typha:v3.27.3 $REGISTRY/calico/typha:v3.27.3
docker tag calico/ctl:v3.27.3 $REGISTRY/calico/ctl:v3.27.3
docker tag calico/node:v3.27.3 $REGISTRY/calico/node:v3.27.3
docker tag calico/cni:v3.27.3 $REGISTRY/calico/cni:v3.27.3
docker tag calico/apiserver:v3.27.3 $REGISTRY/calico/apiserver:v3.27.3
docker tag calico/kube-controllers:v3.27.3 $REGISTRY/calico/kube-controllers:v3.27.3
docker tag calico/dikastes:v3.27.3 $REGISTRY/calico/dikastes:v3.27.3
docker tag calico/pod2daemon-flexvol:v3.27.3 $REGISTRY/calico/pod2daemon-flexvol:v3.27.3
docker tag calico/csi:v3.27.3 $REGISTRY/calico/csi:v3.27.3
docker tag calico/node-driver-registrar:v3.27.3 $REGISTRY/calico/node-driver-registrar:v3.27.3


docker push $REGISTRY/tigera/operator:v1.32.7
docker push $REGISTRY/calico/typha:v3.27.3
docker push $REGISTRY/calico/ctl:v3.27.3
docker push $REGISTRY/calico/node:v3.27.3
docker push $REGISTRY/calico/cni:v3.27.3
docker push $REGISTRY/calico/apiserver:v3.27.3
docker push $REGISTRY/calico/kube-controllers:v3.27.3
docker push $REGISTRY/calico/dikastes:v3.27.3
docker push $REGISTRY/calico/pod2daemon-flexvol:v3.27.3
docker push $REGISTRY/calico/csi:v3.27.3
docker push $REGISTRY/calico/node-driver-registrar:v3.27.3