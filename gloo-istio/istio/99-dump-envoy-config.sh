#!/usr/bin/env bash

# kubectl exec istio-ingress-6ff5d5b79d-6q4g6 -n istio-system -it -- curl 'http://localhost:15000/config_dump'

# Verify rate limiter cluster is properly registered
# istioctl proxy-config cluster istio-ingress-6ff5d5b79d-6q4g6.istio-system -o json

# check rate limiter filter is attached to the http filter chain
# istioctl proxy-config listener istio-ingress-6ff5d5b79d-6q4g6.istio-system -o json

# Verify the route configuration 
# istioctl proxy-config route istio-ingress-6ff5d5b79d-6q4g6.istio-system -o json