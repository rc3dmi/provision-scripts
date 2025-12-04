#!/bin/bash

set -ouex pipefail

### Install Oracle SQL Developer

SRC_URL="https://download.oracle.com/otn_software/java/sqldeveloper/sqldeveloper-24.3.1-347.1826.noarch.rpm"

curl -L -s -o /tmp/sqldeveloper.rpm $SRC_URL
mkdir -p /tmp/sqldeveloper

pushd /tmp/sqldeveloper
rpm2cpio /tmp/sqldeveloper.rpm | cpio -idm
cp opt/sqldeveloper/sqldeveloper.desktop /usr/share/applications
mv usr/local/bin/* /usr/bin
mv opt/sqldeveloper /var/opt
popd

# cleanup tmp files to save space
rm -r /tmp/sqldeveloper.rpm /tmp/sqldeveloper
