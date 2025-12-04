#!/bin/bash

set -ouex pipefail

### Install postgres packages

dnf install -y \
  pgmodeler \
  pgadmin4 \
  pgadmin4-qt
