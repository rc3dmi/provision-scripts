#!/bin/bash

set -e

log_info() {
    echo "[INFO] $1"
}

log_install() {
    log_info "Installing $1..."
}

dnf_install() {
    dnf install -y $@
}

_add_repos() {
    dnf_install \
        dnf-plugins-core
    
    # modified command from official docker docs
    dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

    # rpmfusion and pgadmin repo
    dnf_install \
        https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-fedora-repo-2-1.noarch.rpm \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    
    # copypasta from vscode website
    rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

    # based on vscode copypasta, adding mongodb repo
    echo -e "[mongodb-org-6.0]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/6.0/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc" | sudo tee /etc/yum.repos.d/mongodb-org.repo > /dev/null
}

_install_eclipse_java() {
    ### Download and unpack Eclipes IDE

    ECLIPSE_VER="4.35"
    ECLIPSE_REL="2025-09/R"

    SRC_FILENAME="eclipse-java-${ECLIPSE_REL//\//-}-linux-gtk-x86_64.tar.gz"

    SRC_URL="https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/$ECLIPSE_REL/$SRC_FILENAME&r=1"

    curl -s -L -o /tmp/eclipse.tar.gz $SRC_URL

    install -d /usr/lib
    install -d /usr/bin

    tar --no-same-owner -xf /tmp/eclipse.tar.gz -C /tmp
    mv /tmp/eclipse /usr/lib/eclipse-java
    ln -s /usr/lib/eclipse/eclipse-java /usr/bin/eclipse-java

    for i in 16 22 24 32 48 64 128 256 512 1024
    do
    install -Dm0644 /usr/lib/eclipse-java/plugins/org.eclipse.platform_${ECLIPSE_VER}*/eclipse$i.png \
        "/usr/share/icons/hicolor/${i}x${i}/apps/eclipse-java.png"
    done

    desktop-file-validate /usr/share/applications/eclipse-java.desktop

    # cleanup tmp files to save space
    rm -r /tmp/eclipse.tar.gz
}

_install_eclipse_jee() {
    ### Download and unpack Eclipes IDE

    ECLIPSE_VER="4.35"
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
    install -Dm0644 /usr/lib/eclipse-jee/plugins/org.eclipse.platform_${ECLIPSE_VER}*/eclipse$i.png \
        "/usr/share/icons/hicolor/${i}x${i}/apps/eclipse-jee.png"
    done

    desktop-file-validate /usr/share/applications/eclipse-jee.desktop

    # cleanup tmp files to save space
    rm -r /tmp/eclipse.tar.gz
}

_install_idea() {
    ### Download and unpack Eclipes IDE

    # TODO: Add desktop icon

    IDEA_REL="2025.2.4"

    SRC_FILENAME="ideaIU-$IDEA_REL.tar.gz"
    SRC_URL="https://download.jetbrains.com/idea/$SRC_FILENAME"

    curl -s -L -o /tmp/idea.tar.gz $SRC_URL

    install -d /usr/lib/jetbrains-intellij-idea-ultimate
    install -d /usr/bin

    tar \
    --no-same-owner \
    -xf /tmp/idea.tar.gz \
    -C /usr/lib/jetbrains-intellij-idea-ultimate \
    --strip-components=1

    install -Dm0644 \
    /usr/lib/jetbrains-intellij-idea-ultimate/bin/idea.svg \
    /usr/share/icons/hicolor/scalable/apps/jetbrains-intellij-idea-ultimate.svg

    # cleanup tmp files to save space
    rm -r /tmp/idea.tar.gz
}

_install_nosql_booster() {
    ### Install NoSQLBooster

    BOOSTER_VER="9.1.6"
    BOOSTER_VER_MAJ="${BOOSTER_VER%%.*}"

    SRC_FILENAME="nosqlbooster4mongo-$BOOSTER_VER.tar.gz"
    SRC_URL="https://s3.nosqlbooster.com/download/releasesv$BOOSTER_VER_MAJ/$SRC_FILENAME"

    curl -s -L -o /tmp/nosqlbooster4mongo.tar.gz $SRC_URL

    install -d /usr/lib/nosqlbooster4mongo
    install -d /usr/bin

    tar --no-same-owner -xf /tmp/nosqlbooster4mongo.tar.gz -C /usr/lib/nosqlbooster4mongo --strip-components=1
    ln -s /usr/lib/nosqlbooster4mongo/nosqlbooster4mongo  /usr/bin/nosqlbooster4mongo

    # cleanup tmp files to save space

    rm /tmp/nosqlbooster4mongo.tar.gz
}

_install_sql_developer() {
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
}




log_info "Adding repos..."
_add_repos

log_info "Updating installation..."
dnf -y update






log_install "C packages"
dnf_install \
    gcc \
    gcc-c++ \
    openmpi \
    openmpi-devel

log_install "Docker"
dnf_install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

log_install "Docker Desktop"
dnf_install \
    https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm

log_install "Java"
dnf_install \
    java-21-openjdk-devel

log_install "Node.js"
dnf_install \
    nodejs

log_install "Visual Studio Code"
dnf_install \
    code

log_install "Eclipse Java"
_install_eclipse_java

log_install "Eclipse JEE"
_install_eclipse_jee

log_install "IntelliJ IDEA"
_install_idea

log_install "MongoDB packages"
dnf_install \
    mongodb-org
_install_nosql_booster

log_install "MySQL Workbench"
dnf_install \
    https://downloads.mysql.com/archives/get/p/8/file/mysql-workbench-community-8.0.41-1.fc40.x86_64.rpm

log_install "Postgres packages"
dnf_install \
    pgmodeler \
    pgadmin4-desktop

log_install "Python packages"
dnf_install \
    python3-spyder

log_install "QGIS"
dnf_install \
    qgis

log_install "SQL Developer"
_install_sql_developer

log_install "Wireshark"
dnf_install \
    wireshark

log_install "Bruno"
dnf_install \
    https://github.com/usebruno/bruno/releases/download/v2.15.0/bruno_2.15.0_x86_64_linux.rpm
