#!/bin/bash

set -ouex pipefail

### Install wireshark

dnf install -y \
  wireshark
