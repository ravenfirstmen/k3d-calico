#!/bin/bash

export REGISTRY="k3d-registry.localhost:5000"

export TIGERA_VERSION=1.34.0
export CALICO_VERSION=3.28.0

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

# istio
export ISTIO_VERSION=1.22.0
export ISTIO_PROXY_VERSION=1.18.2

docker pull istio/install-cni:${ISTIO_VERSION}-distroless
docker pull istio/pilot:${ISTIO_VERSION}-distroless
docker pull istio/proxyv2:${ISTIO_PROXY_VERSION}
docker pull istio/proxyv2:${ISTIO_VERSION}-distroless
docker pull istio/ztunnel:${ISTIO_VERSION}

docker tag istio/install-cni:${ISTIO_VERSION}-distroless ${REGISTRY}/istio/install-cni:${ISTIO_VERSION}-distroless
docker tag istio/pilot:${ISTIO_VERSION}-distroless ${REGISTRY}/istio/pilot:${ISTIO_VERSION}-distroless
docker tag istio/proxyv2:${ISTIO_PROXY_VERSION} ${REGISTRY}/istio/proxyv2:${ISTIO_PROXY_VERSION}
docker tag istio/proxyv2:${ISTIO_VERSION}-distroless ${REGISTRY}/istio/proxyv2:${ISTIO_VERSION}-distroless
docker tag istio/ztunnel:${ISTIO_VERSION} ${REGISTRY}/istio/ztunnel:${ISTIO_VERSION}

docker push ${REGISTRY}/istio/install-cni:${ISTIO_VERSION}-distroless
docker push ${REGISTRY}/istio/pilot:${ISTIO_VERSION}-distroless
docker push ${REGISTRY}/istio/proxyv2:${ISTIO_PROXY_VERSION}
docker push ${REGISTRY}/istio/proxyv2:${ISTIO_VERSION}-distroless
docker push ${REGISTRY}/istio/ztunnel:${ISTIO_VERSION}

# gloo
export GLOO_VERSION=1.17.0
export GLOO_SDS_VERSION=1.15.7

docker pull quay.io/solo-io/certgen:${GLOO_VERSION}
docker pull quay.io/solo-io/kubectl:${GLOO_VERSION}
docker pull quay.io/solo-io/gloo-envoy-wrapper:${GLOO_VERSION}
docker pull quay.io/solo-io/sds:${GLOO_SDS_VERSION}
docker pull quay.io/solo-io/gloo:${GLOO_VERSION}
docker pull quay.io/solo-io/ingress:${GLOO_VERSION}
docker pull quay.io/solo-io/discovery:${GLOO_VERSION}

docker tag quay.io/solo-io/certgen:${GLOO_VERSION} ${REGISTRY}/solo-io/certgen:${GLOO_VERSION}
docker tag quay.io/solo-io/kubectl:${GLOO_VERSION} ${REGISTRY}/solo-io/kubectl:${GLOO_VERSION}
docker tag quay.io/solo-io/gloo-envoy-wrapper:${GLOO_VERSION} ${REGISTRY}/solo-io/gloo-envoy-wrapper:${GLOO_VERSION}
docker tag quay.io/solo-io/sds:${GLOO_SDS_VERSION} ${REGISTRY}/solo-io/sds:${GLOO_SDS_VERSION}
docker tag quay.io/solo-io/gloo:${GLOO_VERSION} ${REGISTRY}/solo-io/gloo:${GLOO_VERSION}
docker tag quay.io/solo-io/ingress:${GLOO_VERSION} ${REGISTRY}/solo-io/ingress:${GLOO_VERSION}
docker tag quay.io/solo-io/discovery:${GLOO_VERSION} ${REGISTRY}/solo-io/discovery:${GLOO_VERSION}

docker push ${REGISTRY}/solo-io/certgen:${GLOO_VERSION}
docker push ${REGISTRY}/solo-io/kubectl:${GLOO_VERSION}
docker push ${REGISTRY}/solo-io/gloo-envoy-wrapper:${GLOO_VERSION}
docker push ${REGISTRY}/solo-io/sds:${GLOO_SDS_VERSION}
docker push ${REGISTRY}/solo-io/gloo:${GLOO_VERSION}
docker push ${REGISTRY}/solo-io/ingress:${GLOO_VERSION}
docker push ${REGISTRY}/solo-io/discovery:${GLOO_VERSION}
