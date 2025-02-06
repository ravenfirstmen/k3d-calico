#!/usr/bin/env bash

rl_pod=$(kubectl get pods -l app=rate-limit --namespace istio-system -o json | jq -r '.items[].metadata.name')

# dump rate limit config
echo "==== CONFIG ===="
kubectl exec ${rl_pod} -n istio-system -it -- wget 0:6070/rlconfig -q -O-
# echo "==== STATS ===="
# kubectl exec ${rl_pod} -n istio-system -it -- wget 0:6070/stats -q -O- 
