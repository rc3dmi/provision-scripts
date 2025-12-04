#!/bin/bash

set -ouex pipefail

dnf update -y
dnf install rsync

# copy system files
rsync -rvK sys_files/ /

find scripts -type f -name "*.sh" | sort | while read -r script
do
    echo "running: $script"
    bash $script
done

