#!/bin/bash

set -ouex pipefail

dnf install -y \
    p7zip \
    p7zip-plugins
