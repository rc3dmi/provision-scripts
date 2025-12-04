#!/bin/bash

set -ouex pipefail

### Install Docker

dnf install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

dnf install -y \
  https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm
