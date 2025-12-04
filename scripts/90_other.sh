#!/bin/bash

set -ouex pipefail

# dependencies for maintenance scripts
dnf install -y \
    jq \
    tmux

# netbird
dnf install -y netbird
