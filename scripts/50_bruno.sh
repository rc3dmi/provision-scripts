#!/bin/bash

set -ouex pipefail

dnf install -y \
    https://github.com/usebruno/bruno/releases/download/v2.15.0/bruno_2.15.0_x86_64_linux.rpm
