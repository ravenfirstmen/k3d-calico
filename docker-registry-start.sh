#!/bin/bash

export REGISTRY_NAME="k3d-registry.localhost"
export REGISTRY_PORT="5000"

docker run -d -p 5000:5000 --restart=always --name k3d-registry.localhost -v "$(pwd)/docker-registry.yaml:/etc/docker/registry/config.yml" registry:2