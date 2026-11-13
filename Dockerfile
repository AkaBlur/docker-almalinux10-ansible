FROM quay.io/almalinuxorg/10-init:latest

RUN echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf

RUN dnf -y update && dnf clean all

RUN rm -f /etc/systemd/system/systemd-logind.service

RUN dnf -y install rpm dnf-plugins-core \
    && dnf -y install \
        epel-release \
        initscripts \
        sudo \
        which \
        hostname \
        libyaml \
        python3 \
        python3-pip \
        python3-pyyaml \
        iproute \
        glibc-langpack-en \
    && dnf clean all

RUN rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*

RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN dnf -y install libcurl --allowerasing && dnf clean all
RUN pip3 install --upgrade pip

RUN chmod 0400 /etc/shadow

RUN set -eux; \
    group=$(if command -v yum > /dev/null 2>&1; then echo wheel; else echo sudo; fi); \
    useradd -m -s /bin/bash ansible; \
    usermod -aG "$group" ansible; \
    echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible; \
    chmod 0644 /etc/sudoers.d/ansible

VOLUME [ "/sys/fs/cgroup" ]
CMD [ "/usr/sbin/init" ]
