#!/bin/bash

docker container stop k3d-registry.localhost && docker container rm -v k3d-registry.localhost 