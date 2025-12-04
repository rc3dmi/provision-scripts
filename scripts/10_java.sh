#!/bin/bash

set -ouex pipefail

### Install Java packages

dnf install -y \
  java-21-openjdk-devel
