#!/bin/bash

docker tag kubevirt/libvirt:5.0.0 docker.io/niteshkonkar/libvirt:5.0.0
docker push docker.io/niteshkonkar/libvirt:5.0.0
