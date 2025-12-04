#!/bin/bash

set -ouex pipefail

### Install Node.js from Fedora repos

dnf install -y \
  nodejs
