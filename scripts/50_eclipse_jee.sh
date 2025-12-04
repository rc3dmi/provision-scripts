#!/bin/bash

set -ouex pipefail

### Download and unpack Eclipes IDE

ECLIPSE_REL="2025-09/R"

SRC_FILENAME="eclipse-jee-${ECLIPSE_REL//\//-}-linux-gtk-x86_64.tar.gz"

SRC_URL="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/$ECLIPSE_REL/$SRC_FILENAME&r=1"

curl -s -L -o /tmp/eclipse.tar.gz $SRC_URL

install -d /usr/lib
install -d /usr/bin

tar --no-same-owner -xf /tmp/eclipse.tar.gz -C /tmp
mv /tmp/eclipse /usr/lib/eclipse-jee
ln -s /usr/lib/eclipse/eclipse-jee /usr/bin/eclipse-jee

for i in 16 22 24 32 48 64 128 256 512 1024
do
  install -Dm0644 /usr/lib/eclipse-jee/plugins/org.eclipse.platform_*/eclipse$i.png \
    "/usr/share/icons/hicolor/${i}x${i}/apps/eclipse-jee.png"
done

install -Dm0644 -t /usr/share/applications ../desktop-files/eclipse-jee.desktop
desktop-file-validate /usr/share/applications/eclipse-jee.desktop

# cleanup tmp files to save space
rm -r /tmp/eclipse.tar.gz
