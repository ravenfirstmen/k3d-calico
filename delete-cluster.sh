#!/bin/bash

CERTS_FOLDER="./certs"
rm -rdf "${CERTS_FOLDER}"
k3d cluster delete --config cluster-config.yaml 