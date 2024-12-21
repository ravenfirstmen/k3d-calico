#!/usr/bin/env bash

gateway=$(kubectl get pods -l app=istio-ingress --namespace istio-system -o json | jq -r '.items[].metadata.name')

# dump istio gateway config 
kubectl exec ${gateway} -n istio-system -it -- curl 'http://localhost:15000/config_dump'

# Verify rate limiter cluster is properly registered
istioctl proxy-config cluster ${gateway}.istio-system -o json

# check rate limiter filter is attached to the http filter chain
istioctl proxy-config listener ${gateway}.istio-system -o json

# Verify the route configuration 
istioctl proxy-config route ${gateway}.istio-system -o json