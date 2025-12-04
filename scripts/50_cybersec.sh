#!/bin/bash

set -ouex pipefail

VMWARE_SRC_URL="https://public.dusansimic.me/VMware-Workstation-Full-25H2-24995812.x86_64.bundle"

KALI_VM_SRC_URL="https://cdimage.kali.org/kali-2025.3/kali-linux-2025.3-vmware-amd64.7z"
METASPLOITABLE_VM_SRC_URL="https://downloads.metasploit.com/data/metasploitable/metasploitable-linux-2.0.0.zip"

curl -s -L --retry 5 --retry-delay 10 -o /tmp/vmware.sh $VMWARE_SRC_URL

bash /tmp/vmware.sh

install -d /home/student/VMs

curl -s -L --retry 5 --retry-delay 10 -o /tmp/kalivm.7z $KALI_VM_SRC_URL
curl -s -L --retry 5 --retry-delay 10 -o /tmp/metasploitable.zip $METASPLOITABLE_VM_SRC_URL

7z x /tmp/kalivm.7z -d/home/student/VMs
unzip /tmp/metasploitable.zip -d/home/student/VMs

chown -R student: /home/student/VMs

# cleanup
rm -rf /tmp/vmware.sh /tmp/kalivm.7z /tmp/metasploitable.zip
