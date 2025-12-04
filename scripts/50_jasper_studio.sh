#!/bin/bash

set -ouex pipefail

SRC_URL="https://public.dusansimic.me/js-studiocomm_7.0.3_linux_x86_64.tgz"

curl -L -s -o /tmp/jasper.tgz $SRC_URL
mkdir -p /tmp/jasper-studio

install -d /usr/lib/jasper-studio-community-edition
tar --no-same-owner -xf /tmp/jasper.tgz -C /usr/lib/jasper-studio-community-edition --strip-components=2

ln -s /usr/lib/jasper-studio-community-edition/Jasper\ Studio /usr/bin/jasper-studio-community-edition

install -Dm0644 -t /usr/share/applications ../desktop-files/jasper-studio-community-edition.desktop
desktop-file-validate /usr/share/applications/jasper-studio-community-edition.desktop

# cleanup tmp files to save space
rm -r /tmp/jasper.tgz
