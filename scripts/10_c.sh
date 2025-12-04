#!/bin/bash

set -ouex pipefail

### Install C, C++ and all required libraries

dnf install -y \
  gcc \
  gcc-c++ \
  openmpi \
  openmpi-devel
