#!/bin/bash

export REGISTRY="k3d-registry.localhost:5000"

export TIGERA_VERSION=1.32.7
export CALICO_VERSION=3.27.3

docker pull quay.io/tigera/operator:v${TIGERA_VERSION}
docker pull calico/typha:v${CALICO_VERSION}
docker pull calico/ctl:v${CALICO_VERSION}
docker pull calico/node:v${CALICO_VERSION}
docker pull calico/cni:v${CALICO_VERSION}
docker pull calico/apiserver:v${CALICO_VERSION}
docker pull calico/kube-controllers:v${CALICO_VERSION}
docker pull calico/dikastes:v${CALICO_VERSION}
docker pull calico/pod2daemon-flexvol:v${CALICO_VERSION}
docker pull calico/csi:v${CALICO_VERSION}
docker pull calico/node-driver-registrar:v${CALICO_VERSION}

docker tag quay.io/tigera/operator:v${TIGERA_VERSION} $REGISTRY/tigera/operator:v${TIGERA_VERSION}
docker tag calico/typha:v${CALICO_VERSION} $REGISTRY/calico/typha:v${CALICO_VERSION}
docker tag calico/ctl:v${CALICO_VERSION} $REGISTRY/calico/ctl:v${CALICO_VERSION}
docker tag calico/node:v${CALICO_VERSION} $REGISTRY/calico/node:v${CALICO_VERSION}
docker tag calico/cni:v${CALICO_VERSION} $REGISTRY/calico/cni:v${CALICO_VERSION}
docker tag calico/apiserver:v${CALICO_VERSION} $REGISTRY/calico/apiserver:v${CALICO_VERSION}
docker tag calico/kube-controllers:v${CALICO_VERSION} $REGISTRY/calico/kube-controllers:v${CALICO_VERSION}
docker tag calico/dikastes:v${CALICO_VERSION} $REGISTRY/calico/dikastes:v${CALICO_VERSION}
docker tag calico/pod2daemon-flexvol:v${CALICO_VERSION} $REGISTRY/calico/pod2daemon-flexvol:v${CALICO_VERSION}
docker tag calico/csi:v${CALICO_VERSION} $REGISTRY/calico/csi:v${CALICO_VERSION}
docker tag calico/node-driver-registrar:v${CALICO_VERSION} $REGISTRY/calico/node-driver-registrar:v${CALICO_VERSION}


docker push $REGISTRY/tigera/operator:v${TIGERA_VERSION}
docker push $REGISTRY/calico/typha:v${CALICO_VERSION}
docker push $REGISTRY/calico/ctl:v${CALICO_VERSION}
docker push $REGISTRY/calico/node:v${CALICO_VERSION}
docker push $REGISTRY/calico/cni:v${CALICO_VERSION}
docker push $REGISTRY/calico/apiserver:v${CALICO_VERSION}
docker push $REGISTRY/calico/kube-controllers:v${CALICO_VERSION}
docker push $REGISTRY/calico/dikastes:v${CALICO_VERSION}
docker push $REGISTRY/calico/pod2daemon-flexvol:v${CALICO_VERSION}
docker push $REGISTRY/calico/csi:v${CALICO_VERSION}
docker push $REGISTRY/calico/node-driver-registrar:v${CALICO_VERSION}