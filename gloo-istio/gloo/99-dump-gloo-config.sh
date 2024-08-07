#!/usr/bin/env bash

# kubectl exec gateway-proxy-77c6996b4c-jvfr9 -n gloo-system -it -- wget --quiet 'http://localhost:19000/config_dump' -O-